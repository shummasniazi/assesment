import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants/api_constants.dart';

/// Singleton DIO client for API calls
class DioClient {
  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  late final Dio dio;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(milliseconds: ApiConstants.connectionTimeout),
        receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'Flutter-App/1.0',
        },
        // Don't validate status codes here - let the repository handle them
        validateStatus: (status) => true,
      ),
    );

    // Add interceptors for logging, retry, and error handling
    dio.interceptors.addAll([
      // Retry interceptor for failed requests
      InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          // Retry logic for certain types of errors
          if (_shouldRetry(error)) {
            try {
              // Wait a bit before retrying
              await Future.delayed(const Duration(milliseconds: 500));
              final response = await dio.request(
                error.requestOptions.path,
                options: Options(
                  method: error.requestOptions.method,
                  headers: error.requestOptions.headers,
                ),
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters,
              );
              return handler.resolve(response);
            } catch (e) {
              debugPrint('Retry failed: $e');
            }
          }
          return handler.next(error);
        },
      ),
      // Logging interceptor
      LogInterceptor(
        request: true,
        requestHeader: false, // Don't log headers for cleaner output
        requestBody: false,
        responseHeader: false,
        responseBody: true,
        error: true,
        logPrint: (object) {
          // Only log in debug mode
          if (kDebugMode) {
            debugPrint(object.toString());
          }
        },
      ),
    ]);
  }

  /// Determines if a request should be retried based on the error type
  bool _shouldRetry(DioException error) {
    // Retry on network errors, timeouts, but not on 4xx/5xx status codes
    return error.type == DioExceptionType.connectionTimeout ||
           error.type == DioExceptionType.receiveTimeout ||
           error.type == DioExceptionType.connectionError ||
           error.type == DioExceptionType.unknown;
  }

  /// Create a separate DIO instance for image requests with optimized settings
  Dio get imageDio {
    final imageDio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15), // Faster timeout for images
        receiveTimeout: const Duration(seconds: 30), // Reasonable timeout
        headers: {
          // Minimal headers for faster loading
          'User-Agent': 'Mozilla/5.0 (Linux; Android 10; Mobile) AppleWebKit/537.36',
          'Accept': 'image/webp,image/apng,image/*,*/*;q=0.8',
          'Accept-Encoding': 'gzip, deflate',
          'Connection': 'keep-alive',
        },
        validateStatus: (status) => true,
        // Enable automatic retries for failed requests
        extra: {'withCredentials': false},
      ),
    );

    // Add interceptors for image requests
    imageDio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add referrer for Unsplash images
          if (options.uri.host.contains('unsplash.com')) {
            options.headers['Referer'] = 'https://unsplash.com/';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          debugPrint('Image loading failed: ${error.requestOptions.uri}');
          debugPrint('Error type: ${error.type}');
          debugPrint('Error message: ${error.message}');
          return handler.next(error);
        },
      ),
      // Logging interceptor for images
      LogInterceptor(
        request: false,
        requestHeader: false,
        responseHeader: false,
        responseBody: false,
        error: true,
        logPrint: (object) {
          if (kDebugMode) {
            debugPrint('Image Dio: ${object.toString()}');
          }
        },
      ),
    ]);

    return imageDio;
  }

  /// Alternative image loading method that bypasses some restrictions
  Future<bool> testImageUrl(String url) async {
    try {
      final response = await imageDio.head(url);
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Image URL test failed: $url - $e');
      return false;
    }
  }

  /// Test basic internet connectivity
  Future<bool> testConnectivity() async {
    try {
      final response = await dio.get('/image');
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Connectivity test failed: $e');
      return false;
    }
  }

  /// Test image URL accessibility
  Future<bool> testImageConnectivity(String imageUrl) async {
    try {
      final response = await imageDio.head(imageUrl);
      debugPrint('Image connectivity test: ${response.statusCode}');
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Image connectivity test failed: $e');
      return false;
    }
  }
}

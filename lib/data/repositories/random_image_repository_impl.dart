import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../core/errors/failures.dart';
import '../../core/network/dio_client.dart';
import '../../core/constants/api_constants.dart';
import '../../core/constants/string_constants.dart';
import '../../domain/entities/random_image.dart';
import '../../domain/repositories/random_image_repository.dart';
import '../models/random_image_response.dart';

/// Implementation of RandomImageRepository using DIO
class RandomImageRepositoryImpl implements RandomImageRepository {
  final DioClient dioClient;

  RandomImageRepositoryImpl({required this.dioClient});

  @override
  Future<Either<Failure, RandomImage>> getRandomImage() async {
    const maxRetries = 2; // Reduce retries for faster response
    const retryDelay = Duration(milliseconds: 300); // Faster retry delay

    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        final response = await dioClient.dio.get(
          ApiConstants.randomImageEndpoint,
          options: Options(
            validateStatus: (status) => status != null && status < 500,
          ),
        );

        if (response.statusCode == 200) {
          try {
            final randomImageResponse = RandomImageResponse.fromJson(response.data);
            final randomImage = RandomImage(url: randomImageResponse.url);

            // Validate the URL format
            debugPrint('${StringConstants.repositoryValidatingUrl} ${randomImage.url}');
            if (!_isValidImageUrl(randomImage.url)) {
              debugPrint('${StringConstants.repositoryUrlValidationFailed} ${randomImage.url}');
              return Left(ServerFailure(StringConstants.receivedInvalidImageUrlFromServer));
            }
            debugPrint(StringConstants.repositoryUrlValidationPassed);

            return Right(randomImage);
          } catch (parseError) {
            return Left(ServerFailure(StringConstants.failedToParseServerResponse));
          }
        } else if (response.statusCode == 429) {
          // Rate limited - wait longer before retry
          if (attempt < maxRetries) {
            await Future.delayed(retryDelay * 2);
            continue;
          }
          return Left(ServerFailure(StringConstants.tooManyRequestsPleaseTryAgainLater));
        } else if (response.statusCode! >= 500) {
          // Server error - retry
          if (attempt < maxRetries) {
            await Future.delayed(retryDelay);
            continue;
          }
          return Left(ServerFailure(StringConstants.serverIsTemporarilyUnavailablePleaseTryAgain));
        } else {
          return Left(ServerFailure('${StringConstants.serverReturnedError} ${response.statusCode}'));
        }
      } on DioException catch (e) {
        final errorMessage = _getErrorMessage(e);

        // Retry on network errors
        if (_shouldRetry(e) && attempt < maxRetries) {
          await Future.delayed(retryDelay);
          continue;
        }

        return Left(NetworkFailure(errorMessage));
      } catch (e) {
          return Left(ServerFailure('${StringConstants.unexpectedErrorOccurred} $e'));
      }
    }

    return Left(NetworkFailure(StringConstants.failedToLoadImageAfterMultipleAttempts));
  }

  /// Validates if the URL is a proper image URL
  bool _isValidImageUrl(String url) {
    try {
      final uri = Uri.parse(url);
      // Check if it's a valid absolute URL
      if (!uri.isAbsolute) return false;

      // For Unsplash URLs, just check if it's from images.unsplash.com
      if (uri.host == 'images.unsplash.com') {
        return uri.path.isNotEmpty && uri.path != '/';
      }

      // For other image URLs, check for common image extensions
      return url.toLowerCase().contains('.jpg') ||
             url.toLowerCase().contains('.jpeg') ||
             url.toLowerCase().contains('.png') ||
             url.toLowerCase().contains('.webp') ||
             url.toLowerCase().contains('.gif') ||
             url.toLowerCase().contains('.bmp');
    } catch (e) {
      return false;
    }
  }

  /// Determines if a request should be retried
  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
           error.type == DioExceptionType.receiveTimeout ||
           error.type == DioExceptionType.sendTimeout ||
           error.type == DioExceptionType.connectionError ||
           (error.response?.statusCode != null &&
            error.response!.statusCode! >= 500);
  }

  /// Converts DioException to user-friendly error message
  String _getErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
        return 'Connection timeout. Please check your internet connection and try again.';

      case DioExceptionType.receiveTimeout:
        return 'Server took too long to respond. Please try again.';

      case DioExceptionType.connectionError:
        return 'Unable to connect to server. Please check your internet connection.';

      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 404) {
          return 'Image service is currently unavailable.';
        } else if (e.response?.statusCode == 403) {
          return 'Access to image service is restricted.';
        } else if (e.response?.statusCode == 429) {
          return 'Too many requests. Please wait a moment and try again.';
        }
        return 'Server error occurred. Please try again.';

      case DioExceptionType.cancel:
        return 'Request was cancelled.';

      default:
        return 'Network error occurred. Please check your connection and try again.';
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import '../core/constants/string_constants.dart';
import '../core/network/dio_client.dart';
import '../data/repositories/random_image_repository_impl.dart';
import '../domain/repositories/random_image_repository.dart';
import '../domain/usecases/get_random_image.dart';
import '../presentation/blocs/random_image/random_image_bloc.dart';

/// Service locator for dependency injection
final getIt = GetIt.instance;

/// Initialize all dependencies
Future<void> init() async {
  // Network
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  // Repository
  getIt.registerLazySingleton<RandomImageRepository>(
    () => RandomImageRepositoryImpl(dioClient: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton<GetRandomImage>(
    () => GetRandomImage(getIt()),
  );

  // BLoCs
  getIt.registerFactory<RandomImageBloc>(
    () {
      debugPrint(StringConstants.injectionCreatingRandomImageBloc);
      return RandomImageBloc(getRandomImage: getIt());
    },
  );
}

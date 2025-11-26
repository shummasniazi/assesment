import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/random_image.dart';
import '../repositories/random_image_repository.dart';

/// Use case for getting a random image
class GetRandomImage {
  final RandomImageRepository repository;

  GetRandomImage(this.repository);

  /// Executes the use case to get a random image
  Future<Either<Failure, RandomImage>> call() async {
    return await repository.getRandomImage();
  }
}

import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/random_image.dart';

/// Abstract repository interface for random image operations
abstract class RandomImageRepository {
  /// Fetches a random image from the API
  Future<Either<Failure, RandomImage>> getRandomImage();
}

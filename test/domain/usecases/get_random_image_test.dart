import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:assesment/core/errors/failures.dart';
import 'package:assesment/domain/entities/random_image.dart';
import 'package:assesment/domain/repositories/random_image_repository.dart';
import 'package:assesment/domain/usecases/get_random_image.dart';

// Mock class
class MockRandomImageRepository extends Mock implements RandomImageRepository {}

void main() {
  late GetRandomImage usecase;
  late MockRandomImageRepository mockRepository;

  setUp(() {
    mockRepository = MockRandomImageRepository();
    usecase = GetRandomImage(mockRepository);
  });

  const tUrl = 'https://example.com/image.jpg';
  const tRandomImage = RandomImage(url: tUrl);

  test('should get random image from repository', () async {
    // Arrange
    when(mockRepository.getRandomImage())
        .thenAnswer((_) async => const Right(tRandomImage));

    // Act
    final result = await usecase();

    // Assert
    expect(result, const Right(tRandomImage));
    verify(mockRepository.getRandomImage());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when repository fails', () async {
    // Arrange
    const tFailure = NetworkFailure('Network error');
    when(mockRepository.getRandomImage())
        .thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await usecase();

    // Assert
    expect(result, const Left(tFailure));
    verify(mockRepository.getRandomImage());
    verifyNoMoreInteractions(mockRepository);
  });
}

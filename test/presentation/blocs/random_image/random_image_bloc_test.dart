import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:assesment/core/errors/failures.dart';
import 'package:assesment/domain/entities/random_image.dart';
import 'package:assesment/domain/usecases/get_random_image.dart';
import 'package:assesment/presentation/blocs/random_image/random_image_bloc.dart';
import 'package:assesment/presentation/blocs/random_image/random_image_event.dart';
import 'package:assesment/presentation/blocs/random_image/random_image_state.dart';

// Mock class
class MockGetRandomImage extends Mock implements GetRandomImage {}

void main() {
  late RandomImageBloc bloc;
  late MockGetRandomImage mockGetRandomImage;

  setUp(() {
    mockGetRandomImage = MockGetRandomImage();
    bloc = RandomImageBloc(getRandomImage: mockGetRandomImage);
  });

  tearDown(() {
    bloc.close();
  });

  const tUrl = 'https://example.com/image.jpg';
  const tRandomImage = RandomImage(url: tUrl);

  group('RandomImageBloc', () {
    test('initial state should be RandomImageInitial', () {
      // Assert
      expect(bloc.state, const RandomImageInitial());
    });

    blocTest<RandomImageBloc, RandomImageState>(
      'should emit [Loading, Loaded] when FetchRandomImage is added and succeeds',
      build: () {
        when(mockGetRandomImage())
            .thenAnswer((_) async => const Right(tRandomImage));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchRandomImage()),
      expect: () => [
        const RandomImageLoading(),
        const RandomImageLoaded(randomImage: tRandomImage),
      ],
      verify: (_) => verify(mockGetRandomImage()).called(1),
    );

    blocTest<RandomImageBloc, RandomImageState>(
      'should emit [Loading, Error] when FetchRandomImage is added and fails',
      build: () {
        when(mockGetRandomImage())
            .thenAnswer((_) async => const Left(NetworkFailure('Network error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchRandomImage()),
      expect: () => [
        const RandomImageLoading(),
        const RandomImageError('Network error'),
      ],
      verify: (_) => verify(mockGetRandomImage()).called(1),
    );
  });
}

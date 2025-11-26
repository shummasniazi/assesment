import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../../core/constants/string_constants.dart';
import '../../../domain/usecases/get_random_image.dart';
import 'random_image_event.dart';
import 'random_image_state.dart';

/// BLoC for managing random image state
class RandomImageBloc extends Bloc<RandomImageEvent, RandomImageState> {
  final GetRandomImage getRandomImage;

  RandomImageBloc({
    required this.getRandomImage,
  }) : super(const RandomImageInitial()) {
    on<FetchRandomImage>(_onFetchRandomImage);
  }

  Future<void> _onFetchRandomImage(
    FetchRandomImage event,
    Emitter<RandomImageState> emit,
  ) async {
    debugPrint(StringConstants.blocStartingToFetchRandomImage);
    emit(const RandomImageLoading());

    final result = await getRandomImage();

    await result.fold(
      (failure) async {
        debugPrint('${StringConstants.blocFailedToFetchImage} ${failure.message}');
        debugPrint('${StringConstants.blocErrorType} ${failure.runtimeType}');
        emit(RandomImageError(failure.message));
        debugPrint(StringConstants.blocEmittedRandomImageErrorState);
      },
      (randomImage) async {
        debugPrint('${StringConstants.blocSuccessfullyFetchedImageUrl} ${randomImage.url}');
        // Extract dominant color from the image (temporarily disabled for debugging)
        // final dominantColor = await _extractDominantColor(randomImage.url);
        final dominantColor = null; // Temporarily set to null
        debugPrint(StringConstants.blocDominantColorExtractionSkippedSetToNull);

        emit(RandomImageLoaded(
          randomImage: randomImage,
          dominantColor: dominantColor,
        ));
        debugPrint(StringConstants.blocEmittedRandomImageLoadedState);
      },
    );
  }

}

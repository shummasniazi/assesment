import 'package:equatable/equatable.dart';
import '../../../domain/entities/random_image.dart';

/// States for RandomImageBloc
abstract class RandomImageState extends Equatable {
  const RandomImageState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the bloc is first created
class RandomImageInitial extends RandomImageState {
  const RandomImageInitial();
}

/// State when image is being loaded
class RandomImageLoading extends RandomImageState {
  const RandomImageLoading();
}

/// State when image is successfully loaded
class RandomImageLoaded extends RandomImageState {
  final RandomImage randomImage;
  final int? dominantColor;

  const RandomImageLoaded({
    required this.randomImage,
    this.dominantColor,
  });

  @override
  List<Object?> get props => [randomImage, dominantColor];
}

/// State when an error occurs
class RandomImageError extends RandomImageState {
  final String message;

  const RandomImageError(this.message);

  @override
  List<Object?> get props => [message];
}

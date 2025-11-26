import 'package:equatable/equatable.dart';

/// Events for RandomImageBloc
abstract class RandomImageEvent extends Equatable {
  const RandomImageEvent();

  @override
  List<Object?> get props => [];
}

/// Event to fetch a random image
class FetchRandomImage extends RandomImageEvent {
  const FetchRandomImage();
}

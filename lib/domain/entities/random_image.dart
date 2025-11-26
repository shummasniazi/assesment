import 'package:equatable/equatable.dart';

/// Domain entity for random image
class RandomImage extends Equatable {
  final String url;

  const RandomImage({
    required this.url,
  });

  @override
  List<Object?> get props => [url];
}

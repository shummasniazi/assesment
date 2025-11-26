import 'package:equatable/equatable.dart';

/// API response model for random image endpoint
class RandomImageResponse extends Equatable {
  final String url;

  const RandomImageResponse({
    required this.url,
  });

  factory RandomImageResponse.fromJson(Map<String, dynamic> json) {
    return RandomImageResponse(
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }

  @override
  List<Object?> get props => [url];
}

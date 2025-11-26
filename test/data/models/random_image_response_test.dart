import 'package:flutter_test/flutter_test.dart';
import 'package:assesment/data/models/random_image_response.dart';

void main() {
  const tUrl = 'https://example.com/image.jpg';
  final tJson = {'url': tUrl};
  const tRandomImageResponse = RandomImageResponse(url: tUrl);

  group('RandomImageResponse', () {
    test('should create RandomImageResponse from JSON', () {
      // Act
      final result = RandomImageResponse.fromJson(tJson);

      // Assert
      expect(result, tRandomImageResponse);
    });

    test('should convert RandomImageResponse to JSON', () {
      // Act
      final result = tRandomImageResponse.toJson();

      // Assert
      expect(result, tJson);
    });

    test('should support value equality', () {
      // Arrange
      const response1 = RandomImageResponse(url: tUrl);
      const response2 = RandomImageResponse(url: tUrl);

      // Act & Assert
      expect(response1, response2);
    });

    test('should return correct props', () {
      // Act
      final props = tRandomImageResponse.props;

      // Assert
      expect(props, [tUrl]);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:assesment/domain/entities/random_image.dart';

void main() {
  const tUrl = 'https://example.com/image.jpg';
  const tRandomImage = RandomImage(url: tUrl);

  group('RandomImage', () {
    test('should create RandomImage with correct url', () {
      // Act & Assert
      expect(tRandomImage.url, tUrl);
    });

    test('should support value equality', () {
      // Arrange
      const randomImage1 = RandomImage(url: tUrl);
      const randomImage2 = RandomImage(url: tUrl);

      // Act & Assert
      expect(randomImage1, randomImage2);
    });

    test('should return correct props', () {
      // Act
      final props = tRandomImage.props;

      // Assert
      expect(props, [tUrl]);
    });
  });
}

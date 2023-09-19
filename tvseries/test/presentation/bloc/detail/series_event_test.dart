import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_detail_event.dart';

void main() {
  group('OnFetchSeriesDetail', () {
    test('props should contain the id', () {
      // Arrange
      const id = 1;
      final event = OnFetchSeriesDetail(id);

      // Act
      final props = event.props;

      // Assert
      expect(props, contains(id));
    });

    test('props should not contain other objects', () {
      // Arrange
      const id = 1;
      final event = OnFetchSeriesDetail(id);

      // Act
      final props = event.props;

      // Assert
      expect(props, hasLength(1));
    });
  });
}

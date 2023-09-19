import 'package:flutter_test/flutter_test.dart';

import 'package:tvseries/presentation/bloc/series_detail/series_detail_state.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  group('SeriesDetailState', () {
    test('SDSOnEmpty props should contain the query', () {
      // Arrange
      const query = 'example';
      const state = SDSOnEmpty(query);

      // Act
      final props = state.props;

      // Assert
      expect(props, contains(query));
    });

    test('SDSOnEmpty props should not contain other objects', () {
      // Arrange
      const query = 'example';
      const state = SDSOnEmpty(query);

      // Act
      final props = state.props;

      // Assert
      expect(props, hasLength(1));
    });

    test('SDSOnError props should contain the message', () {
      // Arrange
      const message = 'An error occurred';
      const state = SDSOnError(message);

      // Act
      final props = state.props;

      // Assert
      expect(props, contains(message));
    });

    test('SDSOnError props should not contain other objects', () {
      // Arrange
      const message = 'An error occurred';
      const state = SDSOnError(message);

      // Act
      final props = state.props;

      // Assert
      expect(props, hasLength(1));
    });

    test('SDSOnLoaded props should contain the loadedResult', () {
      // Arrange
      final loadedResult = testSeriesDetail;
      final state = SDSOnLoaded(loadedResult);

      // Act
      final props = state.props;

      // Assert
      expect(props, contains(loadedResult));
    });

    test('SDSOnLoaded props should not contain other objects', () {
      // Arrange
      final loadedResult = testSeriesDetail;
      final state = SDSOnLoaded(loadedResult);

      // Act
      final props = state.props;

      // Assert
      expect(props, hasLength(1));
    });
  });
}

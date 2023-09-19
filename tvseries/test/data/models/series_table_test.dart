import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/data/models/series_table.dart';
import 'package:tvseries/domain/entities/series_detail.dart';

void main() {
  group('SeriesTable Test', () {
    test('fromEntity should convert SeriesDetail to SeriesTable', () {
      // Create a SeriesDetail instance for testing
      const seriesDetail = SeriesDetail(
        id: 1,
        name: 'Test Series',
        posterPath: 'poster.jpg',
        overview: 'This is a test series.',
        backdropPath: '',
        genres: [],
        popularity: 12,
        originalName: '',
        voteAverage: 123,
        voteCount: 1231,
      );

      // Convert SeriesDetail to SeriesTable using the factory method
      final seriesTable = SeriesTable.fromEntity(seriesDetail);

      // Verify that the properties are correctly converted
      expect(seriesTable.id, seriesDetail.id);
      expect(seriesTable.name, seriesDetail.name);
      expect(seriesTable.posterPath, seriesDetail.posterPath);
      expect(seriesTable.overview, seriesDetail.overview);
    });

    test('fromMap should create SeriesTable from a map', () {
      // Create a map with SeriesTable data
      final map = {
        'id': 1,
        'name': 'Test Series',
        'posterPath': 'poster.jpg',
        'overview': 'This is a test series.',
      };

      // Create a SeriesTable instance from the map
      final seriesTable = SeriesTable.fromMap(map);

      // Verify that the properties are correctly set
      expect(seriesTable.id, map['id']);
      expect(seriesTable.name, map['name']);
      expect(seriesTable.posterPath, map['posterPath']);
      expect(seriesTable.overview, map['overview']);
    });

    test('toJson should convert SeriesTable to a map', () {
      // Create a SeriesTable instance for testing
      const seriesTable = SeriesTable(
        id: 1,
        name: 'Test Series',
        posterPath: 'poster.jpg',
        overview: 'This is a test series.',
      );

      // Convert SeriesTable to a map
      final map = seriesTable.toJson();

      // Verify that the map contains the correct data
      expect(map['id'], seriesTable.id);
      expect(map['name'], seriesTable.name);
      expect(map['posterPath'], seriesTable.posterPath);
      expect(map['overview'], seriesTable.overview);
    });

    test('toEntity should convert SeriesTable to SeriesDetail', () {
      // Create a SeriesTable instance for testing
      const seriesTable = SeriesTable(
        id: 1,
        name: 'Test Series',
        posterPath: 'poster.jpg',
        overview: 'This is a test series.',
      );

      // Convert SeriesTable to SeriesDetail using the toEntity method
      final seriesDetail = seriesTable.toEntity();

      // Verify that the properties are correctly converted
      expect(seriesDetail.id, seriesTable.id);
      expect(seriesDetail.name, seriesTable.name);
      expect(seriesDetail.posterPath, seriesTable.posterPath);
      expect(seriesDetail.overview, seriesTable.overview);
    });

    test('props should return a list of properties', () {
      // Create a SeriesTable instance for testing
      const seriesTable = SeriesTable(
        id: 1,
        name: 'Test Series',
        posterPath: 'poster.jpg',
        overview: 'This is a test series.',
      );

      // Get the list of properties
      final props = seriesTable.props;

      // Verify that the list contains the correct properties
      expect(props, [1, 'Test Series', 'poster.jpg', 'This is a test series.']);
    });
  });
}

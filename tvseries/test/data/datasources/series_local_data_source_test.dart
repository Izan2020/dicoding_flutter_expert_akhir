// ignore_for_file: avoid_print

import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/data/datasource/db/series_database_helper.dart';
import 'package:tvseries/data/datasource/series_local_data_source.dart';
import 'package:tvseries/data/models/series_table.dart';

import 'series_local_data_source_test.mocks.dart';

@GenerateMocks([SeriesDatabaseHelper])
void main() {
  late MockSeriesDatabaseHelper seriesDatabaseHelper;
  late SeriesLocalDataSource seriesLocalDataSource;

  setUp(() {
    seriesDatabaseHelper = MockSeriesDatabaseHelper();
    seriesLocalDataSource =
        SeriesLocalDataSourceImpl(seriesDatabaseHelper: seriesDatabaseHelper);
  });

  group('SeriesLocalDataSourceImpl', () {
    test('insertWatchlist should insert a series into the database', () async {
      // Arrange
      const series = SeriesTable(
        id: 1,
        name: 'Test Series',
        posterPath: 'poster.jpg',
        overview: 'This is a test series.',
      );

      when(seriesDatabaseHelper.insertWatchlist(series))
          .thenAnswer((realInvocation) async => 1);

      // Act
      final result = await seriesLocalDataSource.insertWatchlist(series);

      // Assert
      expect(result, 'Added to Watchlist');
    });

    test('deleteWatchlist should delete a series from the database', () async {
      // Arrange
      const series = SeriesTable(
        id: 1,
        name: 'Test Series',
        posterPath: 'poster.jpg',
        overview: 'This is a test series.',
      );

      when(seriesDatabaseHelper.removeWatchlist(series))
          .thenAnswer((realInvocation) async => 1);

      // Act
      final result = await seriesLocalDataSource.deleteWatchlist(series);

      // Assert
      expect(result, 'Deleted from Watchlist');
    });

    test('deleteWatchlist should throw DatabaseException when an error occurs',
        () async {
      // Arrange
      const series = SeriesTable(
        id: 1,
        name: 'Test Series',
        posterPath: 'poster.jpg',
        overview: 'This is a test series.',
      );

      // Stub the insertWatchlist method to throw an exception.
      when(seriesDatabaseHelper.removeWatchlist(series))
          .thenThrow(DatabaseException('Some database error'));

      try {
        final result = await seriesLocalDataSource.deleteWatchlist(series);
        expect(result, throwsA(isA<DatabaseException>()));
      } on DatabaseException catch (e) {
        print('Caught Exception while testing ${e.message}');
      }
    });

    test('getSeriesById should retrieve a series from the database', () async {
      // Arrange
      const series = SeriesTable(
        id: 1,
        name: 'Test Series',
        posterPath: 'poster.jpg',
        overview: 'This is a test series.',
      );

      when(seriesDatabaseHelper.getSeriesbyId(1))
          .thenAnswer((realInvocation) async => {
                "id": 1,
                "name": 'Test Series',
                "posterPath": 'poster.jpg',
                "overview": 'This is a test series.',
              });

      // Act
      final retrievedSeries =
          await seriesLocalDataSource.getSeriesById(series.id);

      // Assert
      expect(retrievedSeries, equals(series));
    });

    test('insertWatchlist should throw DatabaseException when an error occurs',
        () async {
      // Arrange
      const series = SeriesTable(
        id: 1,
        name: 'Test Series',
        posterPath: 'poster.jpg',
        overview: 'This is a test series.',
      );

      // Stub the insertWatchlist method to throw an exception.
      when(seriesDatabaseHelper.insertWatchlist(series))
          .thenThrow(DatabaseException('Some database error'));

      try {
        final result = await seriesLocalDataSource.insertWatchlist(series);
        expect(result, throwsA(isA<DatabaseException>()));
      } on DatabaseException catch (e) {
        print('Caught Exception while testing ${e.message}');
      }
    });

    test(
        'getSeriesWatchlist should retrieve a list of series from the database',
        () async {
      // Arrange
      const series1 = SeriesTable(
        id: 1,
        name: 'Test Series 1',
        posterPath: 'poster1.jpg',
        overview: 'This is a test series 1.',
      );

      const series2 = SeriesTable(
        id: 2,
        name: 'Test Series 2',
        posterPath: 'poster2.jpg',
        overview: 'This is a test series 2.',
      );

      const listOfSeries = <SeriesTable>[series1, series2];

      const mapOflist = [
        {
          "id": 1,
          "name": 'Test Series 1',
          "posterPath": 'poster1.jpg',
          "overview": 'This is a test series 1.',
        },
        {
          "id": 2,
          "name": 'Test Series 2',
          "posterPath": 'poster2.jpg',
          "overview": 'This is a test series 2.',
        }
      ];

      when(seriesDatabaseHelper.getWatchlistSeries())
          .thenAnswer((realInvocation) async => mapOflist);

      // Act
      final retrievedSeriesList =
          await seriesLocalDataSource.getSeriesWatchlist();

      // Assert
      expect(retrievedSeriesList, contains(series1));
      expect(retrievedSeriesList, contains(series2));
      expect(retrievedSeriesList, listOfSeries);
    });
  });
}

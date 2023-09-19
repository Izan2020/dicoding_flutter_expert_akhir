import 'package:flutter_test/flutter_test.dart';

import 'package:movies/data/models/movie_table.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';

// Import your MovieTable class here

void main() {
  group('MovieTable', () {
    test('should create a MovieTable instance from an entity', () {
      // Arrange
      const movieDetail = MovieDetail(
        id: 1,
        title: 'Test Movie',
        posterPath: 'poster.jpg',
        overview: 'This is a test movie.',
        adult: false,
        backdropPath: '',
        genres: [],
        originalTitle: '',
        releaseDate: '',
        runtime: 123123,
        voteAverage: 1231,
        voteCount: 123,
      );

      // Act
      final movieTable = MovieTable.fromEntity(movieDetail);

      // Assert
      expect(movieTable, isA<MovieTable>());
      expect(movieTable.id, equals(movieDetail.id));
      expect(movieTable.title, equals(movieDetail.title));
      expect(movieTable.posterPath, equals(movieDetail.posterPath));
      expect(movieTable.overview, equals(movieDetail.overview));
    });

    test('should create a MovieTable instance from a map', () {
      // Arrange
      final movieMap = {
        'id': 2,
        'title': 'Another Test Movie',
        'posterPath': 'another_poster.jpg',
        'overview': 'This is another test movie.',
      };

      // Act
      final movieTable = MovieTable.fromMap(movieMap);

      // Assert
      expect(movieTable, isA<MovieTable>());
      expect(movieTable.id, equals(movieMap['id']));
      expect(movieTable.title, equals(movieMap['title']));
      expect(movieTable.posterPath, equals(movieMap['posterPath']));
      expect(movieTable.overview, equals(movieMap['overview']));
    });

    test('should convert MovieTable to JSON', () {
      // Arrange
      const movieTable = MovieTable(
        id: 3,
        title: 'JSON Movie',
        posterPath: 'json_poster.jpg',
        overview: 'This is a movie for JSON testing.',
      );

      // Act
      final json = movieTable.toJson();

      // Assert
      expect(json, isA<Map<String, dynamic>>());
      expect(json['id'], equals(movieTable.id));
      expect(json['title'], equals(movieTable.title));
      expect(json['posterPath'], equals(movieTable.posterPath));
      expect(json['overview'], equals(movieTable.overview));
    });

    test('should convert MovieTable to Movie entity', () {
      // Arrange
      const movieTable = MovieTable(
        id: 4,
        title: 'Entity Movie',
        posterPath: 'entity_poster.jpg',
        overview: 'This is a movie for entity testing.',
      );

      // Act
      final movieEntity = movieTable.toEntity();

      // Assert
      expect(movieEntity, isA<Movie>());
      expect(movieEntity.id, equals(movieTable.id));
      expect(movieEntity.title, equals(movieTable.title));
      expect(movieEntity.posterPath, equals(movieTable.posterPath));
      expect(movieEntity.overview, equals(movieTable.overview));
    });

    test('should have the correct props', () {
      // Arrange
      const movieTable1 = MovieTable(
        id: 5,
        title: 'Movie 1',
        posterPath: 'poster1.jpg',
        overview: 'Overview 1',
      );
      const movieTable2 = MovieTable(
        id: 5,
        title: 'Movie 2',
        posterPath: 'poster2.jpg',
        overview: 'Overview 2',
      );

      // Act & Assert
      expect(movieTable1, equals(movieTable1));
      expect(movieTable1, isNot(equals(movieTable2)));
    });
  });
}

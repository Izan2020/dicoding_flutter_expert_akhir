// ignore_for_file: must_be_immutable

import 'package:core/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/data/models/movie_detail_model.dart';
import 'package:movies/domain/entities/movie_detail.dart';

void main() {
  late MovieDetailResponse movieDetailResponse;

  setUp(() {
    movieDetailResponse = const MovieDetailResponse(
      adult: true,
      backdropPath: 'backdrop.jpg',
      budget: 1000000,
      genres: [
        GenreModel(id: 1, name: 'horror'),
        GenreModel(id: 2, name: 'comedy')
      ],
      homepage: 'https://example.com',
      id: 123,
      imdbId: 'tt1234567',
      originalLanguage: 'en',
      originalTitle: 'Original Title',
      overview: 'Movie overview',
      popularity: 7.5,
      posterPath: 'poster.jpg',
      releaseDate: '2023-09-19',
      revenue: 2000000,
      runtime: 120,
      status: 'Released',
      tagline: 'Tagline',
      title: 'Movie Title',
      video: false,
      voteAverage: 8.0,
      voteCount: 1000,
    );
  });

  group('MovieDetailResponse', () {
    test('should create a MovieDetailResponse instance', () {
      // Assert
      expect(movieDetailResponse, isA<MovieDetailResponse>());
    });

    test('should convert MovieDetailResponse to JSON', () {
      // Act
      final json = movieDetailResponse.toJson();

      // Assert
      expect(json, isA<Map<String, dynamic>>());
      // Add more specific expectations for the JSON data here.
    });

    test('should convert MovieDetailResponse to MovieDetail entity', () {
      // Act
      final movieEntity = movieDetailResponse.toEntity();

      // Assert
      expect(movieEntity, isA<MovieDetail>());
      // Add more specific expectations for the MovieDetail entity here.
    });

    test('should have the correct list of props', () {
      // Act
      final props = movieDetailResponse.props;

      // Assert
      expect(props, isA<List<Object?>>());
      // Add more specific expectations for the list of props here.
    });
  });
}

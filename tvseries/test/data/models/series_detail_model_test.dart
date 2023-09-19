import 'package:core/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/data/models/series_detail_model.dart';

void main() {
  group('SeriesDetailResponse Test', () {
    test('fromJson should create SeriesDetailResponse from a map', () {
      // Create a map with SeriesDetailResponse data
      final map = {
        "backdrop_path": "backdrop.jpg",
        "genres": [
          {"id": 1, "name": "Action"},
          {"id": 2, "name": "Adventure"},
        ],
        "homepage": "https://example.com",
        "id": 1,
        "original_language": "en",
        "original_name": "Original Series",
        "overview": "This is a test series.",
        "popularity": 8.5,
        "poster_path": "poster.jpg",
        "status": "Released",
        "tagline": "Tagline",
        "name": "Test Series",
        "vote_average": 9.0,
        "vote_count": 100,
      };

      // Create a SeriesDetailResponse instance from the map
      final seriesDetailResponse = SeriesDetailResponse.fromJson(map);

      // Verify that the properties are correctly set
      expect(seriesDetailResponse.backdropPath, map['backdrop_path']);

      expect(seriesDetailResponse.homepage, map['homepage']);
      expect(seriesDetailResponse.id, map['id']);
      expect(seriesDetailResponse.originalLanguage, map['original_language']);
      expect(seriesDetailResponse.originalName, map['original_name']);
      expect(seriesDetailResponse.overview, map['overview']);
      expect(seriesDetailResponse.popularity, map['popularity']);
      expect(seriesDetailResponse.posterPath, map['poster_path']);
      expect(seriesDetailResponse.status, map['status']);
      expect(seriesDetailResponse.tagline, map['tagline']);
      expect(seriesDetailResponse.name, map['name']);
      expect(seriesDetailResponse.voteAverage, map['vote_average']);
      expect(seriesDetailResponse.voteCount, map['vote_count']);
    });

    test('toJson should convert SeriesDetailResponse to a map', () {
      // Create a SeriesDetailResponse instance for testing
      const seriesDetailResponse = SeriesDetailResponse(
        backdropPath: "backdrop.jpg",
        genres: [
          GenreModel(id: 1, name: "Action"),
          GenreModel(id: 2, name: "Adventure"),
        ],
        homepage: "https://example.com",
        id: 1,
        originalLanguage: "en",
        originalName: "Original Series",
        overview: "This is a test series.",
        popularity: 8.5,
        posterPath: "poster.jpg",
        status: "Released",
        tagline: "Tagline",
        name: "Test Series",
        voteAverage: 9.0,
        voteCount: 100,
      );

      // Convert SeriesDetailResponse to a map
      final map = seriesDetailResponse.toJson();

      // Verify that the map contains the correct data
      expect(map["backdrop_path"], seriesDetailResponse.backdropPath);
      expect(map["genres"], isA<List>());
      expect(map["homepage"], seriesDetailResponse.homepage);
      expect(map["id"], seriesDetailResponse.id);
      expect(map["original_language"], seriesDetailResponse.originalLanguage);
      expect(map["original_name"], seriesDetailResponse.originalName);
      expect(map["overview"], seriesDetailResponse.overview);
      expect(map["popularity"], seriesDetailResponse.popularity);
      expect(map["poster_path"], seriesDetailResponse.posterPath);
      expect(map["status"], seriesDetailResponse.status);
      expect(map["tagline"], seriesDetailResponse.tagline);
      expect(map["name"], seriesDetailResponse.name);
      expect(map["vote_average"], seriesDetailResponse.voteAverage);
      expect(map["vote_count"], seriesDetailResponse.voteCount);
    });

    test('props should return a list of properties', () {
      // Create a SeriesDetailResponse instance for testing
      final seriesDetailResponse = SeriesDetailResponse(
        backdropPath: "backdrop.jpg",
        genres: [
          GenreModel(id: 1, name: "Action"),
          GenreModel(id: 2, name: "Adventure"),
        ],
        homepage: "https://example.com",
        id: 1,
        originalLanguage: "en",
        originalName: "Original Series",
        overview: "This is a test series.",
        popularity: 8.5,
        posterPath: "poster.jpg",
        status: "Released",
        tagline: "Tagline",
        name: "Test Series",
        voteAverage: 9.0,
        voteCount: 100,
      );

      // Get the list of properties
      final props = seriesDetailResponse.props;

      // Verify that the list contains the correct properties
      expect(props, [
        "backdrop.jpg",
        seriesDetailResponse.genres,
        "https://example.com",
        1,
        "en",
        "Original Series",
        "This is a test series.",
        8.5,
        "poster.jpg",
        "Released",
        "Tagline",
        "Test Series",
        9.0,
        100,
      ]);
    });
  });
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/data/models/series_model.dart';
import 'package:tvseries/data/models/series_response.dart';

void main() {
  const tSeriesModel = SeriesModel(
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 1,
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    releaseDate: "2020-05-05",
    name: "Name",
    voteAverage: 1.0,
    voteCount: 1,
  );
  const tSeriesResponseModel =
      SeriesResponse(seriesList: <SeriesModel>[tSeriesModel]);

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "first_air_date": "2020-05-05",
            "name": "Name",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });

  group('fromJson', () {
    test('should retrun a Mapped JSON containing proper data', () {
      final Map<String, dynamic> jsonMap = json.decode(jsonEncode({
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "first_air_date": "2020-05-05",
            "name": "Name",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ]
      }));

      final result = SeriesResponse.fromJson(jsonMap);

      expect(result, tSeriesResponseModel);
    });
  });
}

import 'dart:convert';

import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:tvseries/data/datasource/series_remote_data_source.dart';
import 'package:tvseries/data/models/series_response.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late SeriesRemoteDataSourceImpl dataSource;
  late MockSSLCertifiedClient mockHttp;

  setUp(() {
    mockHttp = MockSSLCertifiedClient();
    dataSource = SeriesRemoteDataSourceImpl(client: mockHttp);
  });

  final jsonSeriesList = jsonEncode({
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
  });
  final tSerieslist = SeriesResponse.fromJson(json.decode(jsonSeriesList));

  group('Get Now Playing Series', () {
    test('should return list of series model when response code is 200 ',
        () async {
      when(mockHttp.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response(jsonSeriesList, 200));

      final result = await dataSource.getAiringTodayTvs();

      expect(result, tSerieslist.seriesList);
    });
    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttp.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getAiringTodayTvs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Popular Series', () {
    test('should return list of series model when response code is 200',
        () async {
      when(mockHttp.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(jsonSeriesList, 200));

      final result = await dataSource.getPopularTvs();

      expect(result, tSerieslist.seriesList);
    });
    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttp.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTvs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Top Rated Series', () {
    test('should return list of series model when response code is 200',
        () async {
      when(mockHttp.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(jsonSeriesList, 200));

      final result = await dataSource.getTopRatedTvs();

      expect(result, tSerieslist.seriesList);
    });
    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttp.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTvs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
  group('Get Series Recommendation', () {
    final tId = 1;
    test('should return list of series model when response code is 200',
        () async {
      when(mockHttp
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(jsonSeriesList, 200));

      final result = await dataSource.getTvRecommendations(tId);

      expect(result, tSerieslist.seriesList);
    });
    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttp
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}

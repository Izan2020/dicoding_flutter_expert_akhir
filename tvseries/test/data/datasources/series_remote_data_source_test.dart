import 'dart:convert';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tvseries/data/datasource/series_remote_data_source.dart';
import 'package:tvseries/data/models/series_detail_model.dart';
import 'package:tvseries/data/models/series_response.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/tvseries.dart';

import '../helper/helper_test.mocks.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('SeriesdataSourceImpl', () {
    late SeriesRemoteDataSource dataSource;
    late MockSSLCertifiedClient mockClient;

    setUp(() {
      mockClient = MockSSLCertifiedClient();
      dataSource = SeriesRemoteDataSourceImpl(client: mockClient);
    });

    final seriesList = <Series>[];

    const seriesDetail = SeriesDetailResponse(
      backdropPath: 'backdrop.jpg',
      genres: [],
      homepage: 'https://example.com',
      id: 1,
      originalLanguage: 'en',
      originalName: 'Original Series',
      overview: 'This is a test series.',
      popularity: 8.5,
      posterPath: 'poster.jpg',
      status: 'Released',
      tagline: 'Tagline',
      name: 'Test Series',
      voteAverage: 9.0,
      voteCount: 100,
    );

    group('getNowPlayingTvs', () {
      test('should return a list of SeriesModel', () async {
        // Arrange
        when(mockClient.get(Uri.parse(
                'https://api.themoviedb.org/3/tv/airing_today?api_key=2174d146bb9c0eab47529b2e77d6b526')))
            .thenAnswer((_) async =>
                http.Response(jsonEncode({'results': seriesList}), 200));

        // Act
        final result = await dataSource.getNowPlayingTvs();

        // Assert
        expect(result, equals(seriesList));
      });

      test(
          'should throw a ServerException if the response status code is not 200',
          () async {
        // Arrange
        when(mockClient.get(Uri.parse(
                'https://api.themoviedb.org/3/tv/airing_today?api_key=2174d146bb9c0eab47529b2e77d6b526')))
            .thenAnswer((_) async => http.Response('Server Error', 500));

        // Act
        final call = dataSource.getNowPlayingTvs;

        // Assert
        expect(() => call(), throwsA(isA<ServerException>()));
      });
    });

    group('getTvDetail', () {
      test('should return a SeriesDetailResponse', () async {
        // Arrange
        final id = 1;
        when(mockClient.get(Uri.parse(
                'https://api.themoviedb.org/3/tv/$id?api_key=2174d146bb9c0eab47529b2e77d6b526')))
            .thenAnswer((_) async =>
                http.Response(jsonEncode(seriesDetail.toJson()), 200));

        // Act
        final result = await dataSource.getTvDetail(id);

        // Assert
        expect(result, equals(seriesDetail));
      });

      test(
          'should throw a ServerException if the response status code is not 200',
          () async {
        // Arrange
        const id = 1;
        when(mockClient.get(Uri.parse(
                'https://api.themoviedb.org/3/tv/$id?api_key=2174d146bb9c0eab47529b2e77d6b526')))
            .thenAnswer((_) async => http.Response('Server Error', 500));

        // Act
        final call = dataSource.getTvDetail;

        // Assert
        expect(() => call(id), throwsA(isA<ServerException>()));
      });
    });

    group('getPopularTvs', () {
      test('should return a list of SeriesModel when the response code is 200',
          () async {
        const expectedResponse = SeriesResponse(seriesList: <SeriesModel>[]);
        when(mockClient.get(any)).thenAnswer((_) async =>
            http.Response(json.encode(expectedResponse.toJson()), 200));

        // Act
        final result = await dataSource.getPopularTvs();

        // Assert
        expect(result, expectedResponse.seriesList);
      });

      test('should throw a ServerException when the response code is not 200',
          () async {
        // Arrange
        when(mockClient.get(any))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // Act
        final call = dataSource.getPopularTvs;

        // Assert
        expect(() => call(), throwsA(isA<ServerException>()));
      });
    });

    group('getTopRatedTvs', () {
      test('should return a list of SeriesModel when the response code is 200',
          () async {
        // Arrange
        const expectedResponse = SeriesResponse(seriesList: <SeriesModel>[]);
        when(mockClient.get(any)).thenAnswer((_) async =>
            http.Response(json.encode(expectedResponse.toJson()), 200));

        // Act
        final result = await dataSource.getTopRatedTvs();

        // Assert
        expect(result, expectedResponse.seriesList);
      });

      test('should throw a ServerException when the response code is not 200',
          () async {
        // Arrange
        when(mockClient.get(any))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // Act
        final call = dataSource.getTopRatedTvs;

        // Assert
        expect(() => call(), throwsA(isA<ServerException>()));
      });
    });

    group('getTvRecommendations', () {
      test('should return a list of SeriesModel when the response code is 200',
          () async {
        // Arrange
        const expectedResponse = SeriesResponse(seriesList: <SeriesModel>[]);
        when(mockClient.get(any)).thenAnswer((_) async =>
            http.Response(json.encode(expectedResponse.toJson()), 200));

        // Act
        final result = await dataSource.getTvRecommendations(1);

        // Assert
        expect(result, expectedResponse.seriesList);
      });

      test('should throw a ServerException when the response code is not 200',
          () async {
        // Arrange
        when(mockClient.get(any))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // Act
        final call = dataSource.getTvRecommendations;

        // Assert
        expect(() => call(1), throwsA(isA<ServerException>()));
      });
    });

    group('searchTvs', () {
      test('should return a list of SeriesModel when the response code is 200',
          () async {
        // Arrange
        const expectedResponse = SeriesResponse(seriesList: <SeriesModel>[]);
        when(mockClient.get(any)).thenAnswer((_) async =>
            http.Response(json.encode(expectedResponse.toJson()), 200));

        // Act
        final result = await dataSource.searchTvs('query');

        // Assert
        expect(result, expectedResponse.seriesList);
      });

      test('should throw a ServerException when the response code is not 200',
          () async {
        // Arrange
        when(mockClient.get(any))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // Act
        final call = dataSource.searchTvs;

        // Assert
        expect(() => call('query'), throwsA(isA<ServerException>()));
      });
    });
  });
}

import 'dart:io';

import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:tvseries/data/models/series_model.dart';
import 'package:tvseries/data/repositories/series_repository_impl.dart';
import 'package:tvseries/domain/entities/series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../helper/helper_test.mocks.dart';

void main() {
  late SeriesRepositoryImpl repository;
  late MockSeriesLocalDataSource localDataSource;
  late MockSeriesRemoteDataSource remoteDataSource;

  setUp(() {
    localDataSource = MockSeriesLocalDataSource();
    remoteDataSource = MockSeriesRemoteDataSource();
    // Bingung
    repository = SeriesRepositoryImpl(
        remoteDataSource: remoteDataSource,
        seriesLocalDataSource: localDataSource);
  });

  const tSeriesModel = SeriesModel(
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 4,
      posterPath: 'posterPath',
      releaseDate: '12 January 22222',
      name: 'name',
      voteAverage: 12,
      voteCount: 4);

  final tSeries = Series(
      backdropPath: 'backdropPath',
      genreIds: const [1, 2, 3],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 4,
      posterPath: 'posterPath',
      releaseDate: '12 January 22222',
      name: 'name',
      voteAverage: 12,
      voteCount: 4);

  final tSeriesModelList = <SeriesModel>[tSeriesModel];

  final tSeriesList = <Series>[tSeries];

  group('getSeriesDetail', () {
    const seriesId = 123; // Replace with the series ID you want to test.

    test(
        'should return SeriesDetail when the call to remote data source is successful',
        () async {
      // Arrange: Define the expected result when calling getTvDetail on the mock.

      when(remoteDataSource.getTvDetail(seriesId))
          .thenAnswer((_) async => testSeriesDetailResponse);

      // Act: Call the repository method.
      final result = await repository.getSeriesDetail(seriesId);

      // Assert: Check that the result is a Right containing the expected SeriesDetail.
      expect(result, Right(testSeriesDetail));
      // Verify that getTvDetail was called with the correct seriesId.
      verify(remoteDataSource.getTvDetail(seriesId));
      // Verify that no other method of the mock was called.
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return a Left(ServerFailure) when the call to remote data source throws a ServerException',
        () async {
      // Arrange: Simulate a ServerException when calling getTvDetail on the mock.
      when(remoteDataSource.getTvDetail(seriesId)).thenThrow(ServerException());

      // Act: Call the repository method.
      final result = await repository.getSeriesDetail(seriesId);

      // Assert: Check that the result is a Left containing a ServerFailure.
      expect(result, Left(ServerFailure('')));
      // Verify that getTvDetail was called with the correct seriesId.
      verify(remoteDataSource.getTvDetail(seriesId));
      // Verify that no other method of the mock was called.
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return a Left(ConnectionFailure) when the call to remote data source throws a SocketException',
        () async {
      // Arrange: Simulate a SocketException when calling getTvDetail on the mock.
      when(remoteDataSource.getTvDetail(seriesId))
          .thenThrow(SocketException(''));

      // Act: Call the repository method.
      final result = await repository.getSeriesDetail(seriesId);

      // Assert: Check that the result is a Left containing a ConnectionFailure.
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
      // Verify that getTvDetail was called with the correct seriesId.
      verify(remoteDataSource.getTvDetail(seriesId));
      // Verify that no other method of the mock was called.
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('Popular Series', () {
    test(
        'should getPopularTvs return remote data to then the response is successful',
        () async {
      when(remoteDataSource.getPopularTvs())
          .thenAnswer((_) async => tSeriesModelList);
      final result = await repository.getPopularTvs();
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test(
        'should return  getPopularTvsremote data to ServerFailure when response is unsuccessful',
        () async {
      when(remoteDataSource.getPopularTvs()).thenThrow(ServerException());

      final result = await repository.getPopularTvs();

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return getPopularTvs remote to ConnectionFailure when the device have no internet',
        () async {
      when(remoteDataSource.getPopularTvs())
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getPopularTvs();

      verify(remoteDataSource.getPopularTvs());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Top Rated Series', () {
    test(
        'should return getTopRatedTvs remote data to then the response is successful',
        () async {
      when(remoteDataSource.getTopRatedTvs())
          .thenAnswer((_) async => tSeriesModelList);
      final result = await repository.getTopRatedSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test(
        'should return getTopRatedTvs remote data to ServerFailure when response is unsuccessful',
        () async {
      when(remoteDataSource.getTopRatedTvs()).thenThrow(ServerException());

      final result = await repository.getTopRatedSeries();

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return getTopRatedTvs remote to ConnectionFailure when the device have no internet',
        () async {
      when(remoteDataSource.getTopRatedTvs())
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getTopRatedSeries();

      verify(remoteDataSource.getTopRatedTvs());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Now Playing Series', () {
    test(
        'should return getAiringTodayTvs remote data to then the response is successful',
        () async {
      when(remoteDataSource.getNowPlayingTvs())
          .thenAnswer((_) async => tSeriesModelList);
      final result = await repository.getNowPlayingSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test(
        'should return getAiringTodayTvs remote data to ServerFailure when response is unsuccessful',
        () async {
      when(remoteDataSource.getNowPlayingTvs()).thenThrow(ServerException());

      final result = await repository.getNowPlayingSeries();

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return getAiringTodayTvs remote to ConnectionFailure when the device have no internet',
        () async {
      when(remoteDataSource.getNowPlayingTvs())
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getNowPlayingSeries();

      verify(remoteDataSource.getNowPlayingTvs());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Recommendation Series', () {
    const tId = 1;
    test(
        'should return getTvRecommendations remote data to then the response is successful',
        () async {
      when(remoteDataSource.getTvRecommendations(tId))
          .thenAnswer((_) async => tSeriesModelList);
      final result = await repository.getSeriesRecommendations(tId);
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test(
        'should return getTvRecommendations remote data to ServerFailure when response is unsuccessful',
        () async {
      when(remoteDataSource.getTvRecommendations(tId))
          .thenThrow(ServerException());

      final result = await repository.getSeriesRecommendations(tId);

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return getTvRecommendations remote to ConnectionFailure when the device have no internet',
        () async {
      when(remoteDataSource.getTvRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getSeriesRecommendations(tId);

      verify(remoteDataSource.getTvRecommendations(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search Series', () {
    const tQuery = 'Sepidermen ';
    test(
        'should return searchTvs remote data to then the response is successful',
        () async {
      when(remoteDataSource.searchTvs(tQuery))
          .thenAnswer((_) async => tSeriesModelList);
      final result = await repository.searchSeries(tQuery);
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test(
        'should return searchTvs remote data to ServerFailure when response is unsuccessful',
        () async {
      when(remoteDataSource.searchTvs(tQuery)).thenThrow(ServerException());

      final result = await repository.searchSeries(tQuery);

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return searchTvs remote to ConnectionFailure when the device have no internet',
        () async {
      when(remoteDataSource.searchTvs(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.searchSeries(tQuery);

      verify(remoteDataSource.searchTvs(tQuery));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Watchlist Series', () {
    test(
        'should return searchTvs local data to then the response is successful',
        () async {
      when(localDataSource.getSeriesWatchlist())
          .thenAnswer((_) async => [testSeriesTable]);
      final result = await repository.getWatchlistSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistSeries]);
    });

    test('should return as success message when series added successfully',
        () async {
      when(localDataSource.insertWatchlist(testSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');

      final result = await repository.saveWatchlistSeries(testSeriesDetail);

      expect(result, const Right('Added to Watchlist'));
    });

    test('should return as error message when series added un-successfully',
        () async {
      when(localDataSource.insertWatchlist(testSeriesTable))
          .thenThrow(DatabaseException('Failed to Added to Watchlist'));

      final result = await repository.saveWatchlistSeries(testSeriesDetail);

      expect(
          result, const Left(DatabaseFailure('Failed to Added to Watchlist')));
    });

    test('should return as success message when series removed successfully',
        () async {
      when(localDataSource.deleteWatchlist(testSeriesTable))
          .thenAnswer((_) async => 'Removed from Watchlist');

      final result = await repository.removeWatchlistSeries(testSeriesDetail);

      expect(result, const Right('Removed from Watchlist'));
    });

    test('should return as error message when series removed un-successfully',
        () async {
      when(localDataSource.deleteWatchlist(testSeriesTable))
          .thenThrow(DatabaseException('Failed to remove rom Watchlist'));

      final result = await repository.removeWatchlistSeries(testSeriesDetail);

      expect(result,
          const Left(DatabaseFailure('Failed to remove rom Watchlist')));
    });

    test('should return watch status whether data is found', () async {
      const tId = 1;
      when(localDataSource.getSeriesById(tId)).thenAnswer((_) async => null);

      final result = await repository.isAddedToWatchlist(tId);

      expect(result, false);
    });
  });
}

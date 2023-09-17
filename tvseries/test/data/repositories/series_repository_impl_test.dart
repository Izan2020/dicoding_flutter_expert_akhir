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

  final tSeriesModelList = <SeriesModel>[tSeriesModel];

  final tSeriesList = <Series>[tSeries];

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

      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return getPopularTvs remote to ConnectionFailure when the device have no internet',
        () async {
      when(remoteDataSource.getPopularTvs())
          .thenThrow(SocketException('Failed to connect to the network'));

      final result = await repository.getPopularTvs();

      verify(remoteDataSource.getPopularTvs());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Top Rated Series', () {
    test(
        'should return getTopRatedTvs remote data to then the response is successful',
        () async {
      when(remoteDataSource.getTopRatedTvs())
          .thenAnswer((_) async => tSeriesModelList);
      final result = await repository.getTopRatedTvs();
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test(
        'should return getTopRatedTvs remote data to ServerFailure when response is unsuccessful',
        () async {
      when(remoteDataSource.getTopRatedTvs()).thenThrow(ServerException());

      final result = await repository.getTopRatedTvs();

      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return getTopRatedTvs remote to ConnectionFailure when the device have no internet',
        () async {
      when(remoteDataSource.getTopRatedTvs())
          .thenThrow(SocketException('Failed to connect to the network'));

      final result = await repository.getTopRatedTvs();

      verify(remoteDataSource.getTopRatedTvs());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Now Playing Series', () {
    test(
        'should return getAiringTodayTvs remote data to then the response is successful',
        () async {
      when(remoteDataSource.getAiringTodayTvs())
          .thenAnswer((_) async => tSeriesModelList);
      final result = await repository.getTvPlayingNow();
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test(
        'should return getAiringTodayTvs remote data to ServerFailure when response is unsuccessful',
        () async {
      when(remoteDataSource.getAiringTodayTvs()).thenThrow(ServerException());

      final result = await repository.getTvPlayingNow();

      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return getAiringTodayTvs remote to ConnectionFailure when the device have no internet',
        () async {
      when(remoteDataSource.getAiringTodayTvs())
          .thenThrow(SocketException('Failed to connect to the network'));

      final result = await repository.getTvPlayingNow();

      verify(remoteDataSource.getAiringTodayTvs());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Recommendation Series', () {
    final tId = 1;
    test(
        'should return getTvRecommendations remote data to then the response is successful',
        () async {
      when(remoteDataSource.getTvRecommendations(tId))
          .thenAnswer((_) async => tSeriesModelList);
      final result = await repository.getTvRecommendations(tId);
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test(
        'should return getTvRecommendations remote data to ServerFailure when response is unsuccessful',
        () async {
      when(remoteDataSource.getTvRecommendations(tId))
          .thenThrow(ServerException());

      final result = await repository.getTvRecommendations(tId);

      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return getTvRecommendations remote to ConnectionFailure when the device have no internet',
        () async {
      when(remoteDataSource.getTvRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));

      final result = await repository.getTvRecommendations(tId);

      verify(remoteDataSource.getTvRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search Series', () {
    final tQuery = 'Sepidermen ';
    test(
        'should return searchTvs remote data to then the response is successful',
        () async {
      when(remoteDataSource.searchTvs(tQuery))
          .thenAnswer((_) async => tSeriesModelList);
      final result = await repository.searchTvs(tQuery);
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test(
        'should return searchTvs remote data to ServerFailure when response is unsuccessful',
        () async {
      when(remoteDataSource.searchTvs(tQuery)).thenThrow(ServerException());

      final result = await repository.searchTvs(tQuery);

      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return searchTvs remote to ConnectionFailure when the device have no internet',
        () async {
      when(remoteDataSource.searchTvs(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));

      final result = await repository.searchTvs(tQuery);

      verify(remoteDataSource.searchTvs(tQuery));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Watchlist Series', () {
    test(
        'should return searchTvs local data to then the response is successful',
        () async {
      when(localDataSource.getSeriesWatchlist())
          .thenAnswer((_) async => [testSeriesTable]);
      final result = await repository.getWatchlistTvs();
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistSeries]);
    });

    test('should return as success message when series added successfully',
        () async {
      when(localDataSource.insertWatchlist(testSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');

      final result = await repository.saveWatchlist(testSeriesDetail);

      expect(result, Right('Added to Watchlist'));
    });

    test('should return as error message when series added un-successfully',
        () async {
      when(localDataSource.insertWatchlist(testSeriesTable))
          .thenThrow(DatabaseException('Failed to Added to Watchlist'));

      final result = await repository.saveWatchlist(testSeriesDetail);

      expect(result, Left(DatabaseFailure('Failed to Added to Watchlist')));
    });

    test('should return as success message when series removed successfully',
        () async {
      when(localDataSource.deleteWatchlist(testSeriesTable))
          .thenAnswer((_) async => 'Removed from Watchlist');

      final result = await repository.removeWatchlist(testSeriesDetail);

      expect(result, Right('Removed from Watchlist'));
    });

    test('should return as error message when series removed un-successfully',
        () async {
      when(localDataSource.deleteWatchlist(testSeriesTable))
          .thenThrow(DatabaseException('Failed to remove rom Watchlist'));

      final result = await repository.removeWatchlist(testSeriesDetail);

      expect(result, Left(DatabaseFailure('Failed to remove rom Watchlist')));
    });

    test('should return watch status whether data is found', () async {
      final tId = 1;
      when(localDataSource.getSeriesById(tId)).thenAnswer((_) async => null);

      final result = await repository.isAddedToWatchlist(tId);

      expect(result, false);
    });
  });
}

import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/domain/usecases/get_now_playing_series.dart';
import 'package:tvseries/domain/usecases/get_popular_series.dart';
import 'package:tvseries/domain/usecases/get_top_rated_series.dart';
import 'package:tvseries/presentation/provider/series_list_notifier.dart';

import 'series_list_notifier_test.mocks.dart';

@GenerateMocks([GetPlayingSeries, GetPopularSeries, GetTopRatedSeries])
void main() {
  late SeriesListNotifier provider;
  late MockGetPlayingSeries mockGetPlayingSeries;
  late MockGetPopularSeries mockGetPopularSeries;
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 1;
    mockGetPlayingSeries = MockGetPlayingSeries();
    mockGetPopularSeries = MockGetPopularSeries();
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    provider = SeriesListNotifier(
        getPlayingSeries: mockGetPlayingSeries,
        getPopularSeries: mockGetPopularSeries,
        getTopRatedSeries: mockGetTopRatedSeries)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tSerie = Series(
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      name: 'name',
      voteAverage: 2,
      voteCount: 1);

  final tSeriesList = <Series>[tSerie];

  group('Popular Series', () {
    test(
      'should change state to loading when usecase is called',
      () {
        when(mockGetPopularSeries.execute())
            .thenAnswer((_) async => Right(tSeriesList));

        provider.fetchPopularSeries();

        expect(provider.popularState, RequestState.Loading);
      },
    );
    test(
      'should change series data when data is gotten successfully',
      () async {
        when(mockGetPopularSeries.execute())
            .thenAnswer((_) async => Right(tSeriesList));

        await provider.fetchPopularSeries();

        expect(provider.listOfPopular, tSeriesList);
      },
    );
    test(
      'should return error when data is unsuccessful',
      () async {
        when(mockGetPopularSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        await provider.fetchPopularSeries();

        expect(provider.popularState, RequestState.Error);
        expect(provider.currentMessage, 'Server Failure');
        expect(listenerCallCount, 4);
      },
    );
  });

  group('Top Rated Series', () {
    test('should change state to loading before usecase is executed', () {
      when(mockGetTopRatedSeries.execute()).thenAnswer(
          (realInvocation) async => Left(ServerFailure('Server Failure')));

      provider.fetchTopRatedSeries();

      expect(provider.topRatedState, RequestState.Loading);
    });
    test('should update series data when data is gotten successfully',
        () async {
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));

      await provider.fetchTopRatedSeries();

      expect(provider.listOfTopRated, tSeriesList);
    });
    test('should return error when data is unsuccessful', () async {
      when(mockGetTopRatedSeries.execute()).thenAnswer(
          (realInvocation) async => Left(ServerFailure('Server Failure')));

      await provider.fetchTopRatedSeries();

      expect(provider.topRatedState, RequestState.Error);
      expect(provider.currentMessage, 'Server Failure');
      expect(listenerCallCount, 4);
    });
  });

  group('Now Playing Series', () {
    test('should change state to loading before usecase is executed', () {
      when(mockGetPlayingSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));

      provider.fetchPlayingSeries();

      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should update NowPlayingSeries when data is gotten successfully',
        () async {
      when(mockGetPlayingSeries.execute())
          .thenAnswer((realInvocation) async => Right(tSeriesList));

      await provider.fetchPlayingSeries();

      expect(provider.listOfNowPlaying, tSeriesList);
    });

    test('should return as error when data is failed to retrieve', () async {
      when(mockGetPlayingSeries.execute()).thenAnswer(
          (realInvocation) async => Left(ServerFailure('Server Failure')));

      await provider.fetchPlayingSeries();

      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.currentMessage, 'Server Failure');
      expect(listenerCallCount, 4);
    });
  });
}

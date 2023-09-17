import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecase/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecase/get_watchlist_series.dart';

import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../tvseries/test/dummy_data/dummy_objects.dart';
import 'watchlist_movie_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies, GetWatchlistSeries])
void main() {
  late WatchlistNotifier provider;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchlistSeries mockGetWatchlistSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchlistSeries = MockGetWatchlistSeries();
    provider = WatchlistNotifier(
      getWatchlistSeries: mockGetWatchlistSeries,
      getWatchlistMovies: mockGetWatchlistMovies,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('Get Watchlist Movie', () {
    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      // act
      await provider.fetchWatchlistMovies();
      // assert
      expect(provider.watchlistStateMovies, RequestState.Loaded);
      expect(provider.watchlistMovies, [testWatchlistMovie]);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      // act
      await provider.fetchWatchlistMovies();
      // assert
      expect(provider.watchlistStateMovies, RequestState.Error);
      expect(provider.messageMovies, "Can't get data");
      expect(listenerCallCount, 2);
    });
  });

  group('Get Watchlist Series', () {
    test('should change series data when data is gotten successfully',
        () async {
      when(mockGetWatchlistSeries.execute())
          .thenAnswer((realInvocation) async => Right([testWatchlistSeries]));

      await provider.fetchWatchlistSeries();

      expect(provider.watchlistStateSeries, RequestState.Loaded);
      expect(provider.watchlistSeries, [testWatchlistSeries]);
      expect(listenerCallCount, 2);
    });
    test('should return error when data is unsuccessful', () async {
      when(mockGetWatchlistSeries.execute()).thenAnswer(
          (realInvocation) async =>
              Left(DatabaseFailure('Unable to Get Data')));

      await provider.fetchWatchlistSeries();

      expect(provider.watchlistStateSeries, RequestState.Error);
      expect(provider.messageSeries, 'Unable to Get Data');
      expect(listenerCallCount, 2);
    });
  });
}

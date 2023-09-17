import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/domain/usecases/get_series_detail.dart';
import 'package:tvseries/domain/usecases/get_series_recommendation.dart';
import 'package:tvseries/domain/usecases/get_watchlist_status_series.dart';
import 'package:tvseries/domain/usecases/remove_watchlist.dart';
import 'package:tvseries/domain/usecases/save_watchlist.dart';
import 'package:tvseries/presentation/provider/series_detail_notifier.dart';

import '../../../../tvseries/test/dummy_data/dummy_objects.dart';
import 'series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetSeriesDetail,
  GetSeriesRecommendation,
  GetWatchlistStatusSeries,
  SaveWatchlistSeries,
  RemoveWatchlistSeries
])
void main() {
  late SeriesDetailNotifier provider;
  late MockGetSeriesDetail mockGetSeriesDetail;
  late MockGetSeriesRecommendation mockGetSeriesRecommendation;
  late MockGetWatchlistStatusSeries mockGetWatchlistStatusSeries;
  late MockSaveWatchlistSeries mockSaveWatchlistSeries;
  late MockRemoveWatchlistSeries mockRemoveWatchlistSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetSeriesDetail = MockGetSeriesDetail();
    mockGetSeriesRecommendation = MockGetSeriesRecommendation();
    mockGetWatchlistStatusSeries = MockGetWatchlistStatusSeries();
    mockSaveWatchlistSeries = MockSaveWatchlistSeries();
    mockRemoveWatchlistSeries = MockRemoveWatchlistSeries();
    provider = SeriesDetailNotifier(
      getSeriesDetail: mockGetSeriesDetail,
      getWatchlistSeriesStatus: mockGetWatchlistStatusSeries,
      saveWatchlistSeries: mockSaveWatchlistSeries,
      removeWatchlistSeries: mockRemoveWatchlistSeries,
      getSeriesRecommendation: mockGetSeriesRecommendation,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;
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
      voteAverage: 1,
      voteCount: 2);
  final tSeriesList = <Series>[tSerie];

  void _arrangeUsecase() {
    when(mockGetSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(testSeriesDetail));
    when(mockGetSeriesRecommendation.execute(tId))
        .thenAnswer((_) async => Right(tSeriesList));
  }

  group('Get Series Detail', () {
    test('should get series data from the usecase', () async {
      _arrangeUsecase();

      await provider.fetchSeriesDetail(tId);

      verify(mockGetSeriesDetail.execute(tId));
      verify(mockGetSeriesRecommendation.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      _arrangeUsecase();

      provider.fetchSeriesDetail(tId);

      expect(provider.seriesDetailState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change series data when data is gotten successfully',
        () async {
      _arrangeUsecase();

      await provider.fetchSeriesDetail(tId);

      expect(provider.seriesDetailState, RequestState.Loaded);
      expect(provider.seriesDetail, testSeriesDetail);
      expect(listenerCallCount, 6);
    });

    test('should change series recommendation when data is gotten successfully',
        () async {
      _arrangeUsecase();
      await provider.fetchSeriesDetail(tId);
      expect(provider.seriesRecommendationState, RequestState.Loaded);
      expect(provider.seriesRecommendations, tSeriesList);
    });
  });
  group('Get Series Recommendation', () {
    test('should get data from the usecase', () async {
      _arrangeUsecase();

      await provider.fetchSeriesDetail(tId);

      verify(mockGetSeriesRecommendation.execute(tId));
      expect(provider.seriesRecommendations, tSeriesList);
    });
  });

  test('should update recommendation state when data is gotten successfully',
      () async {
    _arrangeUsecase();

    await provider.fetchSeriesDetail(tId);

    expect(provider.seriesRecommendationState, RequestState.Loaded);
    expect(provider.seriesRecommendations, tSeriesList);
  });

  test('should update error message when RequestState is in successfull',
      () async {
    when(mockGetSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(testSeriesDetail));
    when(mockGetSeriesRecommendation.execute(tId))
        .thenAnswer((_) async => Left(ServerFailure('Failed')));

    // act
    await provider.fetchSeriesDetail(tId);
    expect(provider.seriesRecommendationState, RequestState.Error);
    expect(provider.currentMessage, 'Failed');
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      when(mockGetWatchlistStatusSeries.execute(1))
          .thenAnswer((_) async => true);

      await provider.loadWatchlistStatus(1);

      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      when(mockSaveWatchlistSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatusSeries.execute(testSeriesDetail.id))
          .thenAnswer((_) async => true);

      await provider.saveWatchlist(testSeriesDetail);

      verify(mockSaveWatchlistSeries.execute(testSeriesDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      when(mockSaveWatchlistSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatusSeries.execute(testSeriesDetail.id))
          .thenAnswer((_) async => true);

      await provider.saveWatchlist(testSeriesDetail);

      verify(mockGetWatchlistStatusSeries.execute(testSeriesDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchListSaveMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      when(mockSaveWatchlistSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => Right('Failed'));
      when(mockGetWatchlistStatusSeries.execute(testSeriesDetail.id))
          .thenAnswer((realInvocation) async => false);

      await provider.saveWatchlist(testSeriesDetail);

      expect(provider.watchListSaveMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('On Error', () {
    test('should return error when data is unsuccessful', () async {
      when(mockGetSeriesDetail.execute(tId)).thenAnswer(
          (realInvocation) async => Left(ServerFailure('Server Failure')));
      when(mockGetSeriesRecommendation.execute(tId))
          .thenAnswer((realInvocation) async => Right(tSeriesList));
      await provider.fetchSeriesDetail(tId);

      expect(provider.seriesDetailState, RequestState.Error);
      expect(provider.currentMessage, 'Server Failure');
      expect(listenerCallCount, 3);
    });
  });
}

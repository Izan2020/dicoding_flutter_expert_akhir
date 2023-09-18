import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/necessary_usecases.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_watchlist_status/series_watchlist_satus_state.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_watchlist_status/series_watchlist_status_bloc.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_watchlist_status/series_watchlist_status_event.dart';

import '../../../../../test/dummy_data/dummy_objects.dart';
import 'series_watchlist_status_test.mocks.dart';

@GenerateMocks([
  GetWatchlistStatusSeries,
  SaveWatchlistSeries,
  RemoveWatchlistSeries,
])
void main() {
  late SeriesWatchlistStatusBloc bloc;
  late MockGetWatchlistStatusSeries usecaseStatus;
  late MockSaveWatchlistSeries usecaseSave;
  late MockRemoveWatchlistSeries usecaseRemove;

  setUp(() {
    usecaseStatus = MockGetWatchlistStatusSeries();
    usecaseSave = MockSaveWatchlistSeries();
    usecaseRemove = MockRemoveWatchlistSeries();
    bloc = SeriesWatchlistStatusBloc(
        getWatchlistStatusSeries: usecaseStatus,
        removeWatchlistSeries: usecaseRemove,
        saveWatchlistSeries: usecaseSave);
  });

  final tId = 1;

  group('Get Watchlist Status', () {
    blocTest<SeriesWatchlistStatusBloc, SeriesWatchlistStatusState>(
      'Should return as false when usecase didnt found the Series in database',
      build: () {
        when(usecaseStatus.execute(1)).thenAnswer((_) async => false);
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(OnLoadWatchlistStatus(tId)),
      expect: () =>
          {SeriesWatchlistStatusState(status: false, message: 'message')},
    );
    blocTest<SeriesWatchlistStatusBloc, SeriesWatchlistStatusState>(
      'Should return as true when usecase found the Series in database',
      build: () {
        when(usecaseStatus.execute(1)).thenAnswer((_) async => true);
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(OnLoadWatchlistStatus(tId)),
      expect: () =>
          {SeriesWatchlistStatusState(status: true, message: 'message')},
    );
  });

  group('Manage Series Watchlist', () {
    blocTest<SeriesWatchlistStatusBloc, SeriesWatchlistStatusState>(
      'Should set state of message "Added to Watchlist" when usecase executed Successfully ',
      build: () {
        when(usecaseSave.execute(testSeriesDetail))
            .thenAnswer((realInvocation) async => Right('Added to Watchlist'));
        when(usecaseStatus.execute(testSeriesDetail.id))
            .thenAnswer((realInvocation) async => true);
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => {bloc.add(OnSaveWatchlist(testSeriesDetail))},
      expect: () => {
        SeriesWatchlistStatusState(message: 'Added to Watchlist', status: true)
      },
    );

    blocTest<SeriesWatchlistStatusBloc, SeriesWatchlistStatusState>(
      'Should set state of message "Deleted from Watchlist" when usecase executed Successfully ',
      build: () {
        when(usecaseRemove.execute(testSeriesDetail)).thenAnswer(
            (realInvocation) async => Right('Deleted from Watchlist'));
        when(usecaseStatus.execute(testSeriesDetail.id))
            .thenAnswer((realInvocation) async => false);
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => {bloc.add(OnRemoveWatchlist(testSeriesDetail))},
      expect: () => {
        SeriesWatchlistStatusState(
            message: 'Deleted from Watchlist', status: false)
      },
    );

    blocTest<SeriesWatchlistStatusBloc, SeriesWatchlistStatusState>(
      'Should set state of message "Database Failure" when RemoveWatchlist usecase execution fails',
      build: () {
        when(usecaseRemove.execute(testSeriesDetail)).thenAnswer(
            (realInvocation) async =>
                Left(DatabaseFailure('Database Failure')));
        when(usecaseStatus.execute(testSeriesDetail.id))
            .thenAnswer((realInvocation) async => false);
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => {bloc.add(OnRemoveWatchlist(testSeriesDetail))},
      expect: () => {
        SeriesWatchlistStatusState(message: 'Database Failure', status: false)
      },
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:core/necessary_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_watchlist_status/movie_watchlist_status_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_watchlist_status/movie_watchlist_status_event.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_watchlist_status/movie_watchlist_status_state.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_status_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlist, RemoveWatchlist, GetWatchListStatusMovie])
void main() {
  late MockSaveWatchlist usecaseSave;
  late MockRemoveWatchlist usecaseRemove;
  late MockGetWatchListStatusMovie usecaseStatus;
  late MovieWatchlistStatusBloc bloc;
  setUp(() {
    usecaseSave = MockSaveWatchlist();
    usecaseRemove = MockRemoveWatchlist();
    usecaseStatus = MockGetWatchListStatusMovie();
    bloc = MovieWatchlistStatusBloc(
        getWatchListStatusMovie: usecaseStatus,
        removeWatchlist: usecaseRemove,
        saveWatchlist: usecaseSave);
  });

  final tId = 1231;

  group('Usecase Status', () {
    blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'Should return as True when watchlist found in database',
      build: () {
        when(usecaseStatus.execute(tId))
            .thenAnswer((realInvocation) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(OnLoadWatchlistStatus(tId)),
      expect: () => {MovieWatchlistStatusState(status: true)},
    );
    blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'Should return as False when watchlist isnt found in database',
      build: () {
        when(usecaseStatus.execute(tId))
            .thenAnswer((realInvocation) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(OnLoadWatchlistStatus(tId)),
      expect: () => {MovieWatchlistStatusState(status: false)},
    );
  });

  group('Usecase Save', () {
    blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'Should return as "Added to Watchlist" when watchlist saved successfully',
      build: () {
        when(usecaseSave.execute(testMovieDetail))
            .thenAnswer((realInvocation) async => Right('Added to Watchlist'));
        when(usecaseStatus.execute(testMovieDetail.id))
            .thenAnswer((realInvocation) async => true);

        return bloc;
      },
      act: (bloc) => bloc.add(OnSaveWatchlist(testMovieDetail)),
      expect: () => {
        MovieWatchlistStatusState(message: 'Added to Watchlist', status: true)
      },
    );
    blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'Should return as "Database Failure" when watchlist saved un-successfully',
      build: () {
        when(usecaseSave.execute(testMovieDetail)).thenAnswer(
            (realInvocation) async =>
                Left(DatabaseFailure('Database OnConflict: Primary Key')));
        when(usecaseStatus.execute(testMovieDetail.id))
            .thenAnswer((realInvocation) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(OnSaveWatchlist(testMovieDetail)),
      expect: () => {
        MovieWatchlistStatusState(message: 'Database OnConflict: Primary Key')
      },
    );
  });

  group('Usecase Remove', () {
    blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'Should return as "Deleted from Watchlist" when watchlist saved successfully',
      build: () {
        when(usecaseRemove.execute(testMovieDetail)).thenAnswer(
            (realInvocation) async => Right('Deleted from Watchlist'));
        when(usecaseStatus.execute(testMovieDetail.id))
            .thenAnswer((realInvocation) async => false);

        return bloc;
      },
      act: (bloc) => bloc.add(OnRemoveWatchlist(testMovieDetail)),
      expect: () => {
        MovieWatchlistStatusState(
            message: 'Deleted from Watchlist', status: false)
      },
    );
    blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'Should return as "Database Failure" when watchlist saved un-successfully',
      build: () {
        when(usecaseRemove.execute(testMovieDetail)).thenAnswer(
            (realInvocation) async =>
                Left(DatabaseFailure('Database OnConflict: Not Found')));
        when(usecaseStatus.execute(testMovieDetail.id))
            .thenAnswer((realInvocation) async => false);

        return bloc;
      },
      act: (bloc) => bloc.add(OnRemoveWatchlist(testMovieDetail)),
      expect: () => {
        MovieWatchlistStatusState(
            message: 'Database OnConflict: Not Found', status: false)
      },
    );
  });
}

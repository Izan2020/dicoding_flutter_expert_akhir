import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecase/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecase/get_watchlist_series.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_event.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:tvseries/domain/entities/series.dart';

import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchlistSeries,
])
void main() {
  late MockGetWatchlistMovies usecaseMovies;
  late MockGetWatchlistSeries usecaseSeries;
  late WatchlistBloc bloc;

  final tSeries = Series(
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 12,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      name: 'name',
      voteAverage: 12,
      voteCount: 123124);
  final tSeriesList = <Series>[tSeries];
  final tSeriesListEmpty = <Series>[];

  final tMovie = Movie(
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originalTitle: 'originalName',
      overview: 'overview',
      popularity: 2,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      title: 'name',
      voteAverage: 3,
      voteCount: 3,
      adult: true,
      video: true);
  final tMovieList = <Movie>[tMovie];
  final tMovieListEmpty = <Movie>[];

  setUp(() {
    usecaseMovies = MockGetWatchlistMovies();
    usecaseSeries = MockGetWatchlistSeries();
    bloc = WatchlistBloc(
      getWatchlistMovies: usecaseMovies,
      getWatchlistSeries: usecaseSeries,
    );
  });

  group('Get Movies', () {
    blocTest<WatchlistBloc, WatchlistState>(
      'should return state of watchlist movies empty when usecase is empty',
      build: () {
        when(usecaseMovies.execute())
            .thenAnswer((realInvocation) async => Right(tMovieListEmpty));
        return bloc;
      },
      act: (bloc) => bloc.add(OnLoadMovies()),
      expect: () =>
          {WatchlistState(listOfMovies: tMovieListEmpty, listOfSeries: [])},
    );
    blocTest<WatchlistBloc, WatchlistState>(
      'should return state of watchlist movies available when usecase is successfully gotten',
      build: () {
        when(usecaseMovies.execute())
            .thenAnswer((realInvocation) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnLoadMovies()),
      expect: () =>
          {WatchlistState(listOfMovies: tMovieList, listOfSeries: [])},
    );
  });

  group('Get Series', () {
    blocTest<WatchlistBloc, WatchlistState>(
      'should return state of watchlist series empty when usecase is empty',
      build: () {
        when(usecaseSeries.execute())
            .thenAnswer((realInvocation) async => Right(tSeriesListEmpty));
        return bloc;
      },
      act: (bloc) => bloc.add(OnLoadSeries()),
      expect: () =>
          {WatchlistState(listOfMovies: [], listOfSeries: tSeriesListEmpty)},
    );
    blocTest<WatchlistBloc, WatchlistState>(
      'should return state of watchlist series available when usecase is successfully gotten',
      build: () {
        when(usecaseSeries.execute())
            .thenAnswer((realInvocation) async => Right(tSeriesList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnLoadSeries()),
      expect: () =>
          {WatchlistState(listOfMovies: [], listOfSeries: tSeriesList)},
    );
  });
}

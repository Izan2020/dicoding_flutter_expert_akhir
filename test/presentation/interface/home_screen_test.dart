import 'package:core/common/enums.dart';
import 'package:core/utils/state_enum.dart';
import 'package:ditonton/presentation/interface/home_screen.dart';
import 'package:ditonton/presentation/provider/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/provider/movie_list_notifier.dart';
import 'package:provider/provider.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/presentation/provider/series_list_notifier.dart';

import 'home_screen_test.mocks.dart';

@GenerateMocks([HomeNotifier, SeriesListNotifier, MovieListNotifier])
void main() {
  late MockHomeNotifier provider;
  late MockSeriesListNotifier mockSeriesListNotifier;
  late MockMovieListNotifier mockMovieListNotifier;
  setUp(() {
    mockSeriesListNotifier = MockSeriesListNotifier();
    mockMovieListNotifier = MockMovieListNotifier();
    provider = MockHomeNotifier();
  });

  Widget _makeTestableWidget() {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<SeriesListNotifier>.value(
              value: mockSeriesListNotifier),
          ChangeNotifierProvider<MovieListNotifier>.value(
              value: mockMovieListNotifier),
          ChangeNotifierProvider<HomeNotifier>.value(value: provider),
        ],
        child: MaterialApp(
          home: HomeScreen(),
        ));
  }

  _assertEvent(HomeEvent event) {
    when(mockMovieListNotifier.nowPlayingMovies).thenReturn(<Movie>[]);
    when(mockSeriesListNotifier.listOfNowPlaying).thenReturn(<Series>[]);

    when(mockMovieListNotifier.popularMovies).thenReturn(<Movie>[]);
    when(mockSeriesListNotifier.listOfPopular).thenReturn(<Series>[]);

    when(mockMovieListNotifier.topRatedMovies).thenReturn(<Movie>[]);
    when(mockSeriesListNotifier.listOfTopRated).thenReturn(<Series>[]);

    when(mockMovieListNotifier.popularMoviesState)
        .thenReturn(RequestState.Loaded);
    when(mockSeriesListNotifier.popularState).thenReturn(RequestState.Loaded);

    when(mockMovieListNotifier.topRatedMoviesState)
        .thenReturn(RequestState.Loaded);
    when(mockSeriesListNotifier.topRatedState).thenReturn(RequestState.Loaded);

    when(mockMovieListNotifier.nowPlayingState).thenReturn(RequestState.Loaded);
    when(mockSeriesListNotifier.nowPlayingState)
        .thenReturn(RequestState.Loaded);

    return when(provider.homeEvent).thenReturn(event);
  }

  testWidgets('Should display Movie Page when event state is Movie ',
      (widgetTester) async {
    _assertEvent(HomeEvent.Movies);

    final moviesPage =
        find.byKey(Key('iL0v3DiCoDiNg!!!!(m0vi3PaG3)!!!!aKuInGiNbInTanG5'));
    await widgetTester.pumpWidget(_makeTestableWidget());
    expect(moviesPage, findsOneWidget);
  });
  testWidgets('Should display Series Page when event state is TvSeries ',
      (widgetTester) async {
    _assertEvent(HomeEvent.TvSeries);
    final seriesPage =
        find.byKey(Key('iL0v3DiCoDiNg!!!!(s3r1e5P4g3)!!!!pL1sB1nt4ngLima'));

    await widgetTester.pumpWidget(_makeTestableWidget());
    expect(seriesPage, findsOneWidget);
  });
}

import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/interface/pages/movie_page.dart';
import 'package:movies/presentation/provider/movie_list_notifier.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../home_screen_test.mocks.dart';

@GenerateMocks([MovieListNotifier])
void main() {
  late MockMovieListNotifier provider;

  setUp(() {
    provider = MockMovieListNotifier();
  });

  Widget _makeTestableWidget() {
    return ChangeNotifierProvider<MovieListNotifier>.value(
      value: provider,
      child: MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: MoviePage())),
      ),
    );
  }

  _assertNowPlayingMovies(RequestState state) {
    when(provider.popularMoviesState).thenReturn(RequestState.Empty);
    when(provider.topRatedMoviesState).thenReturn(RequestState.Empty);

    when(provider.nowPlayingState).thenReturn(state);
    if (state == RequestState.Error) {
      when(provider.message).thenReturn('Failed');
    }
    if (state == RequestState.Loaded) {
      when(provider.nowPlayingMovies).thenReturn(<Movie>[
        testMovie,
        testMovie,
      ]);
    }
  }

  _assertPopularMovies(RequestState state) {
    when(provider.nowPlayingState).thenReturn(RequestState.Empty);
    when(provider.topRatedMoviesState).thenReturn(RequestState.Empty);

    when(provider.popularMoviesState).thenReturn(state);
    if (state == RequestState.Error) {
      when(provider.message).thenReturn('Failed');
    }
    if (state == RequestState.Loaded) {
      when(provider.popularMovies).thenReturn(<Movie>[
        testMovie,
        testMovie,
      ]);
    }
  }

  _assertTopRatedMovies(RequestState state) {
    when(provider.nowPlayingState).thenReturn(RequestState.Empty);
    when(provider.popularMoviesState).thenReturn(RequestState.Empty);

    when(provider.topRatedMoviesState).thenReturn(state);
    if (state == RequestState.Error) {
      when(provider.message).thenReturn('Failed');
    }
    if (state == RequestState.Loaded) {
      when(provider.topRatedMovies).thenReturn(<Movie>[
        testMovie,
        testMovie,
      ]);
    }
  }

  group('Top Rated Movies', () {
    testWidgets('should display CircularLoadingProgress when state is Loading',
        (widgetTester) async {
      _assertTopRatedMovies(RequestState.Loading);
      final loadingIndicator = find.byKey(Key('loading_toprated_movies'));
      await widgetTester.pumpWidget(_makeTestableWidget());
      expect(loadingIndicator, findsOneWidget);
    });
    testWidgets('should display ListView when data is Loaded',
        (widgetTester) async {
      _assertTopRatedMovies(RequestState.Loaded);
      final listView = find.byType(ListView);
      await widgetTester.pumpWidget(_makeTestableWidget());
      expect(listView, findsOneWidget);
    });
    testWidgets('should display error message when data state is Error',
        (widgetTester) async {
      _assertTopRatedMovies(RequestState.Error);
      await widgetTester.pumpWidget(_makeTestableWidget());
    });
  });

  group('Popular Movies', () {
    testWidgets('should display CircularLoadingProgress when state is Loading',
        (widgetTester) async {
      _assertPopularMovies(RequestState.Loading);
      final loadingIndicator = find.byKey(Key('loading_popular_movies'));
      await widgetTester.pumpWidget(_makeTestableWidget());
      expect(loadingIndicator, findsOneWidget);
    });

    testWidgets('should display ListView when state is Loaded',
        (widgetTester) async {
      _assertPopularMovies(RequestState.Loaded);
      final listView = find.byType(ListView);
      await widgetTester.pumpWidget(_makeTestableWidget());
      expect(listView, findsOneWidget);
    });

    testWidgets('should display error message when state is error or empty',
        (widgetTester) async {
      _assertPopularMovies(RequestState.Error);
      final errorMessage = find.byKey(Key('error_message'));
      await widgetTester.pumpWidget(_makeTestableWidget());
      expect(errorMessage, findsWidgets);
    });
  });

  group('Now Playing Movies', () {
    testWidgets('should display CircularLoadingProgress when state is Loading',
        (widgetTester) async {
      _assertNowPlayingMovies(RequestState.Loading);
      final loadingIndicator = find.byKey(Key('loading_now_playing_movies'));
      await widgetTester.pumpWidget(_makeTestableWidget());
      expect(loadingIndicator, findsOneWidget);
    });
    testWidgets('should display ListView when state is Loaded',
        (widgetTester) async {
      _assertNowPlayingMovies(RequestState.Loaded);
      final listView = find.byType(ListView);
      await widgetTester.pumpWidget(_makeTestableWidget());
      expect(listView, findsOneWidget);
    });
    testWidgets('should display Error Message when state is Error',
        (widgetTester) async {
      _assertNowPlayingMovies(RequestState.Error);
      final errorText = find.byKey(Key('error_message'));
      await widgetTester.pumpWidget(_makeTestableWidget());
      expect(errorText, findsWidgets);
    });
  });
}

import 'package:about/presentation/interface/about_screen.dart';
import 'package:core/necessary_utils.dart';
import 'package:core/utils/utils.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/presentation/bloc/home/home_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:ditonton/presentation/interface/home_screen.dart';
import 'package:ditonton/presentation/interface/watchlist_ditonton_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_recommendation/movie_recomendation_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_watchlist_status/movie_watchlist_status_bloc.dart';
import 'package:movies/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:movies/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:movies/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:movies/presentation/interface/screens/movie_detail_screen.dart';
import 'package:movies/presentation/interface/screens/popular_movies_screen.dart';
import 'package:movies/presentation/interface/screens/top_rated_movies_screen.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:search/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:search/presentation/bloc/search_series/search_series_bloc.dart';
import 'package:search/presentation/interface/search_movie_screen.dart';
import 'package:search/presentation/interface/search_series_screen.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_detail_bloc.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_recommendation/series_recommendation_bloc.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_watchlist_status/series_watchlist_status_bloc.dart';
import 'package:tvseries/presentation/bloc/series_now_playing/series_now_playing_bloc.dart';
import 'package:tvseries/presentation/bloc/series_popular/series_popular_bloc.dart';
import 'package:tvseries/presentation/bloc/series_top_rated/series_top_rated_bloc.dart';
import 'package:tvseries/presentation/interface/screens/now_playing_series_screen.dart';
import 'package:tvseries/presentation/interface/screens/popular_series_screen.dart';
import 'package:tvseries/presentation/interface/screens/series_detail_screen.dart';
import 'package:tvseries/presentation/interface/screens/top_rated_series_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<SearchSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesWatchlistStatusBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistStatusBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieNowPLayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<HomeBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeScreen(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeScreen());
            case PopularMoviesScreen.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesScreen());
            case TopRatedMoviesScreen.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesScreen());
            case PopularSeriesScreen.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularSeriesScreen());
            case TopRatedSeriesScreen.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedSeriesScreen());
            case MovieDetailScreen.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailScreen(id: id),
                settings: settings,
              );
            case SeriesDetailScreen.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => SeriesDetailScreen(id: id),
                settings: settings,
              );
            case SearchMovieScreen.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchMovieScreen());
            case SearchSeriesScreen.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchSeriesScreen());
            case WatchlistMoviesScreen.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesScreen());
            case AboutScreen.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutScreen());
            case NowPlayingSeriesScreen.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => NowPlayingSeriesScreen());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}

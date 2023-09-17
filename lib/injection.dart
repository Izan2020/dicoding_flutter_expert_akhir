import 'package:core/utils/ssl_pinning.dart';
import 'package:ditonton/presentation/bloc/home/home_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:movies/data/datasources/db/movie_database_helper.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_recommendation/movie_recomendation_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_watchlist_status/movie_watchlist_status_bloc.dart';
import 'package:movies/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:movies/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:movies/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:search/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:search/presentation/bloc/search_series/search_series_bloc.dart';
import 'package:tvseries/data/datasource/db/series_database_helper.dart';
import 'package:movies/data/datasources/movie_local_data_source.dart';
import 'package:tvseries/data/datasource/series_local_data_source.dart';
import 'package:ditonton/domain/usecase/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecase/get_watchlist_series.dart';

import 'package:get_it/get_it.dart';
import 'package:movies/data/datasources/movie_remote_data_source.dart';
import 'package:movies/data/repositories/movie_repository_impl.dart';

import 'package:tvseries/data/datasource/series_remote_data_source.dart';
import 'package:tvseries/data/repositories/series_repository_impl.dart';

import 'package:tvseries/necessary_usecases.dart';

import 'package:movies/necessary_usecases.dart';

import 'package:search/necessary_usecases.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_detail_bloc.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_recommendation/series_recommendation_bloc.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_watchlist_status/series_watchlist_status_bloc.dart';
import 'package:tvseries/presentation/bloc/series_now_playing/series_now_playing_bloc.dart';
import 'package:tvseries/presentation/bloc/series_popular/series_popular_bloc.dart';
import 'package:tvseries/presentation/bloc/series_top_rated/series_top_rated_bloc.dart';

final locator = GetIt.instance;

void init() {
  // provider

  locator.registerFactory(
    () => SearchSeriesBloc(
      searchSeries: locator(),
    ),
  );
  locator.registerFactory(() => SearchMoviesBloc(
        searchMovies: locator(),
      ));
  locator.registerFactory(() => SeriesDetailBloc(
        getSeriesDetail: locator(),
      ));
  locator.registerFactory(() => SeriesWatchlistStatusBloc(
        getWatchlistStatusSeries: locator(),
        removeWatchlistSeries: locator(),
        saveWatchlistSeries: locator(),
      ));
  locator.registerFactory(() => SeriesRecommendationBloc(
        getSeriesRecommendation: locator(),
      ));
  locator.registerFactory(() => SeriesNowPlayingBloc(
        getPlayingSeries: locator(),
      ));
  locator.registerFactory(() => SeriesTopRatedBloc(
        getTopRatedSeries: locator(),
      ));
  locator.registerFactory(() => SeriesPopularBloc(
        getPopularSeries: locator(),
      ));
  locator.registerFactory(
      () => MovieRecommendationBloc(getMovieRecommendations: locator()));
  locator.registerFactory(() => MovieWatchlistStatusBloc(
        getWatchListStatusMovie: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
      ));
  locator.registerFactory(() => MovieDetailBloc(
        getMovieDetail: locator(),
      ));
  locator.registerFactory(
      () => MovieNowPLayingBloc(getNowPlayingMovies: locator()));
  locator.registerFactory(() => MoviePopularBloc(
        getPopularMovies: locator(),
      ));
  locator.registerFactory(() => MovieTopRatedBloc(
        getTopRatedMovies: locator(),
      ));
  locator.registerFactory(() => WatchlistBloc(
        getWatchlistMovies: locator(),
        getWatchlistSeries: locator(),
      ));
  locator.registerFactory(
    () => HomeBloc(),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusMovie(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => SearchSeries(locator()));
  locator.registerLazySingleton(() => GetPlayingSeries(locator()));
  locator.registerLazySingleton(() => GetPopularSeries(locator()));
  locator.registerLazySingleton(() => GetSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetSeriesRecommendation(locator()));
  locator.registerLazySingleton(() => GetWatchlistStatusSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedSeries(locator()));

  locator.registerLazySingleton(() => GetWatchlistSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<SeriesRepository>(() => SeriesRepositoryImpl(
      remoteDataSource: locator(), seriesLocalDataSource: locator()));

  // helper
  locator.registerLazySingleton<MovieDatabaseHelper>(
    () => MovieDatabaseHelper(),
  );
  locator.registerLazySingleton<SeriesDatabaseHelper>(
    () => SeriesDatabaseHelper(),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<SeriesRemoteDataSource>(
      () => SeriesRemoteDataSourceImpl(client: locator()));

  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(movieDatabaseHelper: locator()));
  locator.registerLazySingleton<SeriesLocalDataSource>(
      () => SeriesLocalDataSourceImpl(seriesDatabaseHelper: locator()));

  // external
  locator.registerLazySingleton<SSLCertifiedClient>(
    () => SSLCertifiedClient(),
  );
}

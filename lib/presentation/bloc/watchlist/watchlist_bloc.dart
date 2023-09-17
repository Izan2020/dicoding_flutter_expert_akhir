import 'package:ditonton/domain/usecase/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecase/get_watchlist_series.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_event.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchlistSeries getWatchlistSeries;
  WatchlistBloc(
      {required this.getWatchlistMovies, required this.getWatchlistSeries})
      : super(WatchlistState(
          listOfMovies: [],
          listOfSeries: [],
        )) {
    on<OnLoadMovies>((event, emit) async {
      final result = await getWatchlistMovies.execute();
      result.fold(
        (l) => null,
        (r) => emit(WatchlistState(
          listOfMovies: r,
          listOfSeries: state.listOfSeries,
        )),
      );
    });
    on<OnLoadSeries>((event, emit) async {
      final result = await getWatchlistSeries.execute();
      result.fold(
        (l) => null,
        (r) => emit(WatchlistState(
          listOfMovies: state.listOfMovies,
          listOfSeries: r,
        )),
      );
    });
  }
}

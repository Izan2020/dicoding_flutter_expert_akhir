import 'package:core/utils/state_enum.dart';
import 'package:ditonton/domain/usecase/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecase/get_watchlist_series.dart';
import 'package:flutter/foundation.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:tvseries/domain/entities/series.dart';

class WatchlistNotifier extends ChangeNotifier {
  var _watchlistSeries = <Series>[];
  List<Series> get watchlistSeries => _watchlistSeries;

  var _watchlistMovies = <Movie>[];
  List<Movie> get watchlistMovies => _watchlistMovies;

  var _watchlistStateSeries = RequestState.Empty;
  RequestState get watchlistStateSeries => _watchlistStateSeries;

  var _watchlistStateMovies = RequestState.Empty;
  RequestState get watchlistStateMovies => _watchlistStateMovies;

  String _messageMovies = '';
  String get messageMovies => _messageMovies;

  String _messageSeries = '';
  String get messageSeries => _messageSeries;

  WatchlistNotifier({
    required this.getWatchlistMovies,
    required this.getWatchlistSeries,
  });

  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchlistSeries getWatchlistSeries;

  Future<void> fetchWatchlistMovies() async {
    _watchlistStateMovies = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        _messageMovies = failure.message;
        _watchlistStateMovies = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _watchlistMovies = moviesData;
        _watchlistStateMovies = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchWatchlistSeries() async {
    _watchlistStateSeries = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistSeries.execute();

    result.fold((failure) {
      _messageSeries = failure.message;
      _watchlistStateSeries = RequestState.Error;
      notifyListeners();
    }, (seriesData) {
      _watchlistSeries = seriesData;
      _watchlistStateSeries = RequestState.Loaded;

      notifyListeners();
    });
  }
}

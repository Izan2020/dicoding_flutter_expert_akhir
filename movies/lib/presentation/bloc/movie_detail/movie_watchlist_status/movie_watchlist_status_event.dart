import 'package:movies/domain/entities/movie_detail.dart';

class MovieWatchlistStatusEvent {
  MovieWatchlistStatusEvent();
}

class OnLoadWatchlistStatus extends MovieWatchlistStatusEvent {
  final int id;
  OnLoadWatchlistStatus(this.id);
}

class OnSaveWatchlist extends MovieWatchlistStatusEvent {
  final MovieDetail movieDetail;
  OnSaveWatchlist(this.movieDetail);
}

class OnRemoveWatchlist extends MovieWatchlistStatusEvent {
  final MovieDetail movieDetail;
  OnRemoveWatchlist(this.movieDetail);
}

class MovieDetailEvent {
  MovieDetailEvent();
}

class OnFetchMovieDetail extends MovieDetailEvent {
  final int id;
  OnFetchMovieDetail(this.id);
}

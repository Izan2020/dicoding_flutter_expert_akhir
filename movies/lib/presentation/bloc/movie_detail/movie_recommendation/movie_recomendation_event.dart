class MovieRecommendationEvent {
  MovieRecommendationEvent();
}

class OnFetchMovieRecomendation extends MovieRecommendationEvent {
  final int id;
  OnFetchMovieRecomendation(this.id);
}

abstract class SeriesRecommendationEvent {
  const SeriesRecommendationEvent();
}

class OnFetchSeriesRecommendation extends SeriesRecommendationEvent {
  final int id;
  const OnFetchSeriesRecommendation(this.id);
}

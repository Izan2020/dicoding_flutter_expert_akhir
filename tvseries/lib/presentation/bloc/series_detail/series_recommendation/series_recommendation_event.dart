import 'package:equatable/equatable.dart';

abstract class SeriesRecommendationEvent extends Equatable {
  const SeriesRecommendationEvent();
  @override
  List<Object?> get props => [];
}

class OnFetchSeriesRecommendation extends SeriesRecommendationEvent {
  final int id;
  const OnFetchSeriesRecommendation(this.id);
  @override
  List<Object> get props => [id];
}

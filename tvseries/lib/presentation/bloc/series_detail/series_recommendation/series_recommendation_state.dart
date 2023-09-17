import 'package:equatable/equatable.dart';
import 'package:tvseries/tvseries.dart';

abstract class SeriesRecommendationState extends Equatable {
  const SeriesRecommendationState();
  @override
  List<Object?> get props => [];
}

class SRSOnInit extends SeriesRecommendationState {
  const SRSOnInit();
}

class SRSOnLoading extends SeriesRecommendationState {
  const SRSOnLoading();
}

class SRSOnError extends SeriesRecommendationState {
  final String message;
  const SRSOnError(this.message);
  @override
  List<Object?> get props => [message];
}

class SRSOnLoaded extends SeriesRecommendationState {
  final List<Series> seriesRecommendations;
  const SRSOnLoaded(this.seriesRecommendations);
  @override
  List<Object?> get props => [seriesRecommendations];
}

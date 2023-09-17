import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';

class MovieRecommendationState extends Equatable {
  const MovieRecommendationState();
  @override
  List<Object?> get props => [];
}

class MRSOnInit extends MovieRecommendationState {}

class MRSOnLoading extends MovieRecommendationState {}

class MRSOnError extends MovieRecommendationState {
  final String message;
  const MRSOnError(this.message);
}

class MRSOnLoaded extends MovieRecommendationState {
  final List<Movie> listOfMovies;

  const MRSOnLoaded(this.listOfMovies);
}

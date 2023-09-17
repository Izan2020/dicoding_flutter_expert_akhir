// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';

class MoviePopularState extends Equatable {
  MoviePopularState();
  @override
  List<Object?> get props => [];
}

class MPSOnInit extends MoviePopularState {}

class MPSOnLoading extends MoviePopularState {}

class MPSOnError extends MoviePopularState {
  final String message;
  MPSOnError(this.message);
}

class MPSOnLoaded extends MoviePopularState {
  final List<Movie> listOfMovies;
  MPSOnLoaded(this.listOfMovies);
}

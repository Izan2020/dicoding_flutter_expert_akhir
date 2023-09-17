// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';

class MovieTopRatedState extends Equatable {
  MovieTopRatedState();
  @override
  List<Object?> get props => [];
}

class MTROnInit extends MovieTopRatedState {}

class MTROnLoading extends MovieTopRatedState {}

class MTROnError extends MovieTopRatedState {
  final String message;
  MTROnError(this.message);
}

class MTROnLoaded extends MovieTopRatedState {
  final List<Movie> listOfMovies;
  MTROnLoaded(this.listOfMovies);
}

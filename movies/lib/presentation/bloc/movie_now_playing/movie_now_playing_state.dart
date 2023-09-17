// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';

class MovieNowPlayingState extends Equatable {
  MovieNowPlayingState();
  @override
  List<Object?> get props => [];
}

class MSPOnInit extends MovieNowPlayingState {}

class MSPOnLoading extends MovieNowPlayingState {}

class MSPOnError extends MovieNowPlayingState {
  final String message;
  MSPOnError(this.message);
}

class MSPOnLoaded extends MovieNowPlayingState {
  final List<Movie> listOfMovies;
  MSPOnLoaded(this.listOfMovies);
}

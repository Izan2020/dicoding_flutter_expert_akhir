// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie_detail.dart';

class MovieDetailState extends Equatable {
  MovieDetailState();
  @override
  List<Object?> get props => [];
}

class MDSOnInit extends MovieDetailState {}

class MDSOnLoading extends MovieDetailState {}

class MDSOnError extends MovieDetailState {
  final String message;
  MDSOnError(this.message);
}

class MDSOnLoaded extends MovieDetailState {
  final MovieDetail movieDetail;
  MDSOnLoaded(this.movieDetail);
}

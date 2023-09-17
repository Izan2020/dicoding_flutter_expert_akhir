// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:core/domain/genre.dart';
import 'package:equatable/equatable.dart';

class SeriesDetail extends Equatable {
  const SeriesDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.popularity,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  final String backdropPath;
  final List<Genre> genres;
  final int id;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String name;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        originalName,
        overview,
        posterPath,
        name,
        voteAverage,
        voteCount,
      ];
}

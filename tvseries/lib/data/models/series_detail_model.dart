// SeriesDetailResponse
// ignore_for_file: depend_on_referenced_packages

import 'package:core/data/models/genre_model.dart';
import 'package:equatable/equatable.dart';

import 'package:tvseries/domain/entities/series_detail.dart';

class SeriesDetailResponse extends Equatable {
  const SeriesDetailResponse({
    required this.backdropPath,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });
  final String backdropPath;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final String originalLanguage;
  final String originalName;
  final String overview;

  final double popularity;
  final String posterPath;
  final String status;
  final String tagline;
  final String name;
  final double voteAverage;
  final int voteCount;

  factory SeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      SeriesDetailResponse(
          backdropPath: json["backdrop_path"],
          genres: List<GenreModel>.from(
              json["genres"].map((x) => GenreModel.fromJson(x))),
          homepage: json["homepage"],
          id: json["id"],
          originalLanguage: json["original_language"],
          originalName: json["original_name"],
          overview: json["overview"],
          popularity: json["popularity"].toDouble(),
          posterPath: json["poster_path"] ?? '',
          status: json["status"],
          tagline: json["tagline"],
          name: json["name"],
          voteAverage: json["vote_average"].toDouble(),
          voteCount: json["vote_count"]);

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "status": status,
        "tagline": tagline,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
  SeriesDetail toEntity() {
    return SeriesDetail(
        popularity: popularity,
        backdropPath: backdropPath,
        genres: genres.map((genre) => genre.toEntity()).toList(),
        id: id,
        originalName: originalName,
        overview: overview,
        posterPath: posterPath,
        name: name,
        voteAverage: voteAverage,
        voteCount: voteCount);
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        homepage,
        id,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        status,
        tagline,
        name,
        voteAverage,
        voteCount,
      ];
}

// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/series_detail.dart';

import '../../domain/entities/series.dart';

class SeriesTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  const SeriesTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory SeriesTable.fromEntity(SeriesDetail series) => SeriesTable(
        id: series.id,
        name: series.name,
        posterPath: series.posterPath,
        overview: series.overview,
      );

  factory SeriesTable.fromMap(Map<String, dynamic> map) => SeriesTable(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  Series toEntity() => Series.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}

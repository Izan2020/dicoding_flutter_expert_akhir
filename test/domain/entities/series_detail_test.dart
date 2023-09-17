import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/genre.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tvseries/data/models/series_detail_model.dart';

import 'package:tvseries/domain/entities/series_detail.dart';

void main() {
  final tSeriesDetailResponse = SeriesDetailResponse(
      backdropPath: 'backdropPath',
      genres: [GenreModel(id: 1, name: 'name')],
      homepage: 'homepage',
      id: 1,
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      status: 'status',
      tagline: 'tagline',
      name: 'name',
      voteAverage: 1,
      voteCount: 1);
  final tSeriesDetail = SeriesDetail(
      backdropPath: 'backdropPath',
      genres: [Genre(id: 1, name: 'name')],
      id: 1,
      popularity: 1,
      originalName: 'originalName',
      overview: 'overview',
      posterPath: 'posterPath',
      name: 'name',
      voteAverage: 1,
      voteCount: 1);

  test('should be the subclass of SeriesDetailResponse ', () {
    final result = tSeriesDetailResponse.toEntity();
    expect(result, tSeriesDetail);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/data/models/series_model.dart';
import 'package:tvseries/domain/entities/series.dart';

void main() {
  final tSeriesModel = SeriesModel(
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 4,
      posterPath: 'posterPath',
      releaseDate: '12 January 22222',
      name: 'name',
      voteAverage: 12,
      voteCount: 4);

  final tSeries = Series(
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 4,
      posterPath: 'posterPath',
      releaseDate: '12 January 22222',
      name: 'name',
      voteAverage: 12,
      voteCount: 4);

  test('should be subclass of model (API Response)', () {
    expect(tSeriesModel.toEntity(), tSeries);
  });
}

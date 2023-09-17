import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/domain/repositories/series_repository.dart';

class GetSeriesRecommendation {
  final SeriesRepository repository;
  GetSeriesRecommendation(this.repository);

  Future<Either<Failure, List<Series>>> execute(int id) {
    return repository.getTvRecommendations(id);
  }
}

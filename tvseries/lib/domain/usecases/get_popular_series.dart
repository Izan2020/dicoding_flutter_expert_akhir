import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/domain/repositories/series_repository.dart';

class GetPopularSeries {
  final SeriesRepository repository;
  GetPopularSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() {
    return repository.getPopularTvs();
  }
}

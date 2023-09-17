import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/domain/repositories/series_repository.dart';

class GetPlayingSeries {
  final SeriesRepository repository;
  GetPlayingSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() {
    return repository.getTvPlayingNow();
  }
}

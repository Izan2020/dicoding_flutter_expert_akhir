import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/entities/series_detail.dart';
import 'package:tvseries/domain/repositories/series_repository.dart';

class RemoveWatchlistSeries {
  final SeriesRepository seriesRepository;
  RemoveWatchlistSeries(this.seriesRepository);

  Future<Either<Failure, String>> execute(SeriesDetail tv) {
    return seriesRepository.removeWatchlistSeries(tv);
  }
}

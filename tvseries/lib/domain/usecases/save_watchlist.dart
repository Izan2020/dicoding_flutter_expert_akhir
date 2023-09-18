import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/entities/series_detail.dart';
import 'package:tvseries/domain/repositories/series_repository.dart';

class SaveWatchlistSeries {
  final SeriesRepository seriesRepository;
  SaveWatchlistSeries(this.seriesRepository);

  Future<Either<Failure, String>> execute(SeriesDetail tv) {
    return seriesRepository.saveWatchlistSeries(tv);
  }
}

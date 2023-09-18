import 'package:dartz/dartz.dart';
import 'package:core/necessary_utils.dart';
import 'package:tvseries/necessary_usecases.dart';
import 'package:tvseries/necessary_entities.dart';

class GetWatchlistSeries {
  final SeriesRepository seriesRepository;
  GetWatchlistSeries(this.seriesRepository);

  Future<Either<Failure, List<Series>>> execute() {
    return seriesRepository.getWatchlistSeries();
  }
}

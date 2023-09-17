import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/domain/repositories/series_repository.dart';

class SearchSeries {
  final SeriesRepository seriesRepository;
  SearchSeries(this.seriesRepository);
  Future<Either<Failure, List<Series>>> execute(String query) async {
    return seriesRepository.searchTvs(query);
  }
}

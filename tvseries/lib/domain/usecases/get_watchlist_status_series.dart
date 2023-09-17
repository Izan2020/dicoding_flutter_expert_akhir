import 'package:tvseries/domain/repositories/series_repository.dart';

class GetWatchlistStatusSeries {
  final SeriesRepository seriesRepository;
  GetWatchlistStatusSeries(this.seriesRepository);

  Future<bool> execute(int id) {
    return seriesRepository.isAddedToWatchlist(id);
  }
}

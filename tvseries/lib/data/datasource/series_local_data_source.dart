import 'package:core/utils/exception.dart';
import 'package:tvseries/data/datasource/db/series_database_helper.dart';
import 'package:tvseries/data/models/series_table.dart';

abstract class SeriesLocalDataSource {
  Future<String> insertWatchlist(SeriesTable series);
  Future<String> deleteWatchlist(SeriesTable series);
  Future<SeriesTable?> getSeriesById(int id);
  Future<List<SeriesTable>> getSeriesWatchlist();
}

class SeriesLocalDataSourceImpl implements SeriesLocalDataSource {
  final SeriesDatabaseHelper seriesDatabaseHelper;
  SeriesLocalDataSourceImpl({required this.seriesDatabaseHelper});

  @override
  Future<String> deleteWatchlist(SeriesTable series) async {
    try {
      await seriesDatabaseHelper.removeWatchlist(series);
      return 'Deleted from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<SeriesTable?> getSeriesById(int id) async {
    final result = await seriesDatabaseHelper.getSeriesbyId(id);
    if (result != null) {
      return SeriesTable.fromMap(result);
    }
    return null;
  }

  @override
  Future<List<SeriesTable>> getSeriesWatchlist() async {
    final result = await seriesDatabaseHelper.getWatchlistSeries();
    return result.map((e) => SeriesTable.fromMap(e)).toList();
  }

  @override
  Future<String> insertWatchlist(SeriesTable series) async {
    try {
      await seriesDatabaseHelper.insertWatchlist(series);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}

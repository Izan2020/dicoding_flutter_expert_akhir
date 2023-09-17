import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/domain/entities/series_detail.dart';

abstract class SeriesRepository {
  Future<Either<Failure, List<Series>>> getTvPlayingNow();
  Future<Either<Failure, List<Series>>> getPopularTvs();
  Future<Either<Failure, List<Series>>> getTopRatedTvs();
  Future<Either<Failure, SeriesDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Series>>> getTvRecommendations(int id);
  Future<Either<Failure, List<Series>>> searchTvs(String query);
  Future<Either<Failure, String>> saveWatchlist(SeriesDetail tv);
  Future<Either<Failure, String>> removeWatchlist(SeriesDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Series>>> getWatchlistTvs();
}

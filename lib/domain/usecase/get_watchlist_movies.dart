import 'package:dartz/dartz.dart';
import 'package:movies/necessary_usecases.dart';
import 'package:movies/necessary_entities.dart';
import 'package:core/necessary_utils.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}

import 'package:dartz/dartz.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/necessary_usecases.dart';
import 'package:core/necessary_utils.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}

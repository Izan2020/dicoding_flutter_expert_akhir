import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:tvseries/domain/entities/series.dart';

class WatchlistState extends Equatable {
  final List<Movie> listOfMovies;
  final List<Series> listOfSeries;
  WatchlistState({
    required this.listOfMovies,
    required this.listOfSeries,
  });

  @override
  List<Object?> get props => [listOfMovies, listOfSeries];
}

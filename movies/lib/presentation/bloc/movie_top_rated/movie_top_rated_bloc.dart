import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/necessary_usecases.dart';
import 'package:movies/presentation/bloc/movie_top_rated/movie_top_rated_event.dart';
import 'package:movies/presentation/bloc/movie_top_rated/movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;
  MovieTopRatedBloc({required this.getTopRatedMovies}) : super(MTROnInit()) {
    on<OnFetchTopRatedMovie>((event, emit) async {
      emit(MTROnLoading());
      final result = await getTopRatedMovies.execute();
      result.fold(
        (l) => emit(MTROnError(l.message)),
        (r) => emit(MTROnLoaded(r)),
      );
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:movies/necessary_usecases.dart';
import 'package:movies/presentation/bloc/movie_popular/movie_popular_event.dart';
import 'package:movies/presentation/bloc/movie_popular/movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies getPopularMovies;
  MoviePopularBloc({required this.getPopularMovies}) : super(MPSOnInit()) {
    on<OnFetchPopularMoviesEvent>((event, emit) async {
      emit(MPSOnLoading());
      final result = await getPopularMovies.execute();
      result.fold(
        (l) => emit(MPSOnError(l.message)),
        (r) => emit(MPSOnLoaded(r)),
      );
    });
  }
}

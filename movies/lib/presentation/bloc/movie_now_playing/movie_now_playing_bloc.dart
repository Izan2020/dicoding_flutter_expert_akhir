import 'package:bloc/bloc.dart';
import 'package:movies/necessary_usecases.dart';
import 'package:movies/presentation/bloc/movie_now_playing/movie_now_playing_event.dart';
import 'package:movies/presentation/bloc/movie_now_playing/movie_now_playing_state.dart';

class MovieNowPLayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  MovieNowPLayingBloc({required this.getNowPlayingMovies})
      : super(MSPOnInit()) {
    on<OnFetchNowPLayingEvent>((event, emit) async {
      emit(MSPOnLoading());
      final result = await getNowPlayingMovies.execute();
      result.fold(
        (l) => emit(MSPOnError(l.message)),
        (r) => emit(MSPOnLoaded(r)),
      );
    });
  }
}

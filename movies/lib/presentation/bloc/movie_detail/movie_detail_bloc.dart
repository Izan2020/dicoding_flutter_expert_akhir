import 'package:bloc/bloc.dart';
import 'package:movies/necessary_usecases.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  MovieDetailBloc({required this.getMovieDetail}) : super(MDSOnInit()) {
    on<OnFetchMovieDetail>((event, emit) async {
      emit(MDSOnLoading());
      final result = await getMovieDetail.execute(event.id);
      result.fold(
        (l) => emit(MDSOnError(l.message)),
        (r) => emit(MDSOnLoaded(r)),
      );
    });
  }
}

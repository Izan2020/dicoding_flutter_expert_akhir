import 'package:bloc/bloc.dart';
import 'package:movies/necessary_usecases.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_recommendation/movie_recomendation_event.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_recommendation/movie_recomendation_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;
  MovieRecommendationBloc({required this.getMovieRecommendations})
      : super(MRSOnInit()) {
    on<OnFetchMovieRecomendation>((event, emit) async {
      emit(MRSOnLoading());
      final result = await getMovieRecommendations.execute(event.id);
      result.fold(
        (l) => emit(MRSOnError(l.message)),
        (r) => emit(MRSOnLoaded(r)),
      );
    });
  }
}

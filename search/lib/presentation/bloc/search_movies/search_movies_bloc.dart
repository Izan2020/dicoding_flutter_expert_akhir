import 'package:core/utils/debouncer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecase/search_movies.dart';
import 'package:search/presentation/bloc/search_event.dart';
import 'package:search/presentation/bloc/search_state.dart';

class SearchMoviesBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies searchMovies;
  SearchMoviesBloc({required this.searchMovies}) : super(OnInit()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      emit(OnLoading());
      final result = await searchMovies.execute(query);
      result.fold(
        (failure) => emit(OnError(failure.message)),
        (searchResult) => {
          if (searchResult.isNotEmpty)
            {emit(OnLoaded(searchResult))}
          else
            {emit(OnEmpty(query))}
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

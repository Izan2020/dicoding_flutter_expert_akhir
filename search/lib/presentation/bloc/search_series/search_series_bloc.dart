import 'package:core/utils/debouncer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/necessary_usecases.dart';
import 'package:search/presentation/bloc/search_event.dart';
import 'package:search/presentation/bloc/search_state.dart';

class SearchSeriesBloc extends Bloc<SearchEvent, SearchState> {
  final SearchSeries searchSeries;
  SearchSeriesBloc({required this.searchSeries}) : super(OnInit()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      emit(OnLoading());
      final result = await searchSeries.execute(query);
      result.fold(
        (failure) => emit(OnError(failure.message)),
        (searchResult) {
          if (searchResult.isNotEmpty) {
            emit(OnLoaded(searchResult));
          } else {
            emit(OnEmpty(query));
          }
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

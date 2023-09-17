import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/usecases/get_popular_series.dart';
import 'package:tvseries/presentation/bloc/series_popular/series_popular_event.dart';
import 'package:tvseries/presentation/bloc/series_popular/series_popular_state.dart';

class SeriesPopularBloc extends Bloc<SeriesPopularEvent, SeriesPopularState> {
  final GetPopularSeries getPopularSeries;
  SeriesPopularBloc({required this.getPopularSeries}) : super(PSEOnInit()) {
    on<OnFetchPopularSeries>((event, emit) async {
      emit(PSEOnLoading());
      final result = await getPopularSeries.execute();
      result.fold(
        (l) => emit(PSEOnError(l.message)),
        (r) => emit(PSEOnLoaded(r)),
      );
    });
  }
}

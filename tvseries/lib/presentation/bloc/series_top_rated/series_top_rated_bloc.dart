import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/necessary_usecases.dart';
import 'package:tvseries/presentation/bloc/series_top_rated/series_top_rated_event.dart';
import 'package:tvseries/presentation/bloc/series_top_rated/series_top_rated_state.dart';

class SeriesTopRatedBloc
    extends Bloc<SeriesTopRatedEvent, SeriesTopRatedState> {
  final GetTopRatedSeries getTopRatedSeries;
  SeriesTopRatedBloc({required this.getTopRatedSeries}) : super(TRSOnInit()) {
    on<OnFetchTopRatedSeries>((event, emit) async {
      emit(TRSOnLoading());
      final result = await getTopRatedSeries.execute();
      result.fold(
        (l) => emit(TRSOnError(l.message)),
        (r) => emit(TRSOnLoaded(r)),
      );
    });
  }
}

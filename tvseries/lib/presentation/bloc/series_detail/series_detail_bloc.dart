import 'package:bloc/bloc.dart';
import 'package:tvseries/necessary_usecases.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_detail_event.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_detail_state.dart';

class SeriesDetailBloc extends Bloc<SeriesDetailEvent, SeriesDetailState> {
  final GetSeriesDetail getSeriesDetail;
  SeriesDetailBloc({required this.getSeriesDetail}) : super(SDSOnInit()) {
    on<OnFetchSeriesDetail>(
      (event, emit) async {
        emit(SDSOnLoading());
        final result = await getSeriesDetail.execute(event.id);
        result.fold(
          (failure) => emit(SDSOnError(failure.message)),
          (seriesDetail) => emit(SDSOnLoaded(seriesDetail)),
        );
      },
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:tvseries/necessary_usecases.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_recommendation/series_recommendation_event.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_recommendation/series_recommendation_state.dart';

class SeriesRecommendationBloc
    extends Bloc<SeriesRecommendationEvent, SeriesRecommendationState> {
  final GetSeriesRecommendation getSeriesRecommendation;
  SeriesRecommendationBloc({required this.getSeriesRecommendation})
      : super(const SRSOnInit()) {
    on<OnFetchSeriesRecommendation>((event, emit) async {
      emit(const SRSOnLoading());
      final result = await getSeriesRecommendation.execute(event.id);
      result.fold(
        (failure) => emit(SRSOnError(failure.message)),
        (seriesRecommendation) => emit(SRSOnLoaded(seriesRecommendation)),
      );
    });
  }
}

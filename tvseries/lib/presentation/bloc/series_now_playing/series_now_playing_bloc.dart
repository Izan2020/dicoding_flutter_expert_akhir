import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/necessary_usecases.dart';
import 'package:tvseries/presentation/bloc/series_now_playing/series_now_playing_event.dart';
import 'package:tvseries/presentation/bloc/series_now_playing/series_now_playing_state.dart';

class SeriesNowPlayingBloc
    extends Bloc<SeriesNowPlayingEvent, SeriesNowPlayingState> {
  final GetPlayingSeries getPlayingSeries;
  SeriesNowPlayingBloc({required this.getPlayingSeries}) : super(NPSOnInit()) {
    on<OnFetchNowPlayingSeries>((event, emit) async {
      emit(NPSOnLoading());
      final result = await getPlayingSeries.execute();
      result.fold(
        (l) => emit(NPSOnError(l.message)),
        (r) => emit(NPSOnLoaded(r)),
      );
    });
  }
}

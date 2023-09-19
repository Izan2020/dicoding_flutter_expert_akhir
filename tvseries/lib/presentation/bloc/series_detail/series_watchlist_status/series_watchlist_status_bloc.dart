import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/usecases/get_watchlist_status_series.dart';
import 'package:tvseries/domain/usecases/remove_watchlist.dart';
import 'package:tvseries/domain/usecases/save_watchlist.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_watchlist_status/series_watchlist_satus_state.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_watchlist_status/series_watchlist_status_event.dart';

class SeriesWatchlistStatusBloc
    extends Bloc<SeriesWatchlistStatusEvent, SeriesWatchlistStatusState> {
  final GetWatchlistStatusSeries getWatchlistStatusSeries;
  final RemoveWatchlistSeries removeWatchlistSeries;
  final SaveWatchlistSeries saveWatchlistSeries;
  static const addSuccessMessage = 'Added to Watchlist';
  static const removeSuccessMessage = 'Deleted from Watchlist';
  SeriesWatchlistStatusBloc({
    required this.getWatchlistStatusSeries,
    required this.removeWatchlistSeries,
    required this.saveWatchlistSeries,
  }) : super(const SeriesWatchlistStatusState()) {
    on<OnLoadWatchlistStatus>(
      (event, emit) async {
        final result = await getWatchlistStatusSeries.execute(event.id);
        emit(SeriesWatchlistStatusState(status: result));
      },
    );

    on<OnRemoveWatchlist>((event, emit) async {
      final result = await removeWatchlistSeries.execute(event.series);
      var message = '';
      result.fold(
        (l) {
          message = l.message;
        },
        (r) {
          message = r;
        },
      );
      final status = await getWatchlistStatusSeries.execute(event.series.id);
      emit(SeriesWatchlistStatusState(status: status, message: message));
    });
    on<OnSaveWatchlist>((event, emit) async {
      final result = await saveWatchlistSeries.execute(event.series);
      var message = '';
      result.fold(
        (l) {
          message = l.message;
        },
        (r) {
          message = r;
        },
      );
      final status = await getWatchlistStatusSeries.execute(event.series.id);
      emit(SeriesWatchlistStatusState(status: status, message: message));
    });
  }
}

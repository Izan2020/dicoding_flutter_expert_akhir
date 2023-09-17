import 'package:bloc/bloc.dart';
import 'package:movies/necessary_usecases.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_watchlist_status/movie_watchlist_status_event.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_watchlist_status/movie_watchlist_status_state.dart';

class MovieWatchlistStatusBloc
    extends Bloc<MovieWatchlistStatusEvent, MovieWatchlistStatusState> {
  final GetWatchListStatusMovie getWatchListStatusMovie;
  final RemoveWatchlist removeWatchlist;
  final SaveWatchlist saveWatchlist;
  static const addSuccessMessage = 'Added to Watchlist';
  static const removeSuccessMessage = 'Removed from Watchlist';
  MovieWatchlistStatusBloc({
    required this.getWatchListStatusMovie,
    required this.removeWatchlist,
    required this.saveWatchlist,
  }) : super(MovieWatchlistStatusState()) {
    on<OnLoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatusMovie.execute(event.id);
      emit(MovieWatchlistStatusState(status: result, message: state.message));
    });
    on<OnSaveWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.movieDetail);
      String message = '';
      result.fold(
        (l) {
          message = l.message;
        },
        (r) {
          message = r;
        },
      );
      final status =
          await getWatchListStatusMovie.execute(event.movieDetail.id);
      emit(MovieWatchlistStatusState(status: status, message: message));
    });
    on<OnRemoveWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movieDetail);
      String message = '';
      result.fold(
        (l) {
          message = l.message;
        },
        (r) {
          message = r;
        },
      );
      final status =
          await getWatchListStatusMovie.execute(event.movieDetail.id);
      emit(MovieWatchlistStatusState(status: status, message: message));
    });
  }
}

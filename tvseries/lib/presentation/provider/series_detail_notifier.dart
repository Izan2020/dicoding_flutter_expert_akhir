import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/domain/entities/series_detail.dart';
import 'package:tvseries/domain/usecases/get_series_detail.dart';
import 'package:tvseries/domain/usecases/get_series_recommendation.dart';
import 'package:tvseries/domain/usecases/get_watchlist_status_series.dart';
import 'package:tvseries/domain/usecases/remove_watchlist.dart';
import 'package:tvseries/domain/usecases/save_watchlist.dart';

class SeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Deleted from Watchlist';

  late SeriesDetail _seriesDetail;
  SeriesDetail get seriesDetail => _seriesDetail;

  RequestState _seriesDetailState = RequestState.Empty;
  RequestState get seriesDetailState => _seriesDetailState;

  RequestState _seriesRecommendationState = RequestState.Empty;
  RequestState get seriesRecommendationState => _seriesRecommendationState;

  var _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  String _currentMessage = '';
  String get currentMessage => _currentMessage;

  String _watchListSaveMessage = '';
  String get watchListSaveMessage => _watchListSaveMessage;

  List<Series> _seriesRecommendations = [];
  List<Series> get seriesRecommendations => _seriesRecommendations;

  SeriesDetailNotifier({
    required this.getSeriesDetail,
    required this.getWatchlistSeriesStatus,
    required this.saveWatchlistSeries,
    required this.removeWatchlistSeries,
    required this.getSeriesRecommendation,
  });
  final GetSeriesDetail getSeriesDetail;
  final GetSeriesRecommendation getSeriesRecommendation;
  final GetWatchlistStatusSeries getWatchlistSeriesStatus;
  final SaveWatchlistSeries saveWatchlistSeries;
  final RemoveWatchlistSeries removeWatchlistSeries;

  Future<void> fetchSeriesDetail(int id) async {
    _setSeriesDetailState(RequestState.Loading);
    final resultDetail = await getSeriesDetail.execute(id);
    final resultRecommendations = await getSeriesRecommendation.execute(id);
    resultDetail.fold((failure) {
      _currentMessage = failure.message;
      notifyListeners();
      _setSeriesDetailState(RequestState.Error);
    }, (seriesDetail) {
      _seriesDetail = seriesDetail;
      notifyListeners();
      _setRecommendationState(RequestState.Loading);
      resultRecommendations.fold(
        (failure) {
          _currentMessage = failure.message;
          notifyListeners();
          _setRecommendationState(RequestState.Error);
        },
        (recommendationList) {
          _seriesRecommendations = recommendationList;
          notifyListeners();
          _setRecommendationState(RequestState.Loaded);
        },
      );
      _setSeriesDetailState(RequestState.Loaded);
    });
  }

  Future<void> removeWatchlist(SeriesDetail tv) async {
    final result = await removeWatchlistSeries.execute(tv);

    await result.fold(
      (failure) async {
        debugPrint('Failure Watchlist ${failure.message}');
        _watchListSaveMessage = failure.message;
      },
      (success) async {
        debugPrint('Success Remove ${success.length}');
        _watchListSaveMessage = success;
      },
    );
    await loadWatchlistStatus(tv.id);
  }

  Future<void> saveWatchlist(SeriesDetail tv) async {
    final result = await saveWatchlistSeries.execute(tv);
    await result.fold(
      (failure) async {
        debugPrint('Failure Watchlist ${failure.message}');
        _watchListSaveMessage = failure.message;
      },
      (success) async {
        debugPrint('Success Saved${success.length}');
        _watchListSaveMessage = success;
      },
    );
    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchlistSeriesStatus.execute(id);
    _isAddedToWatchlist = result;
    notifyListeners();
  }

  _setSeriesDetailState(RequestState value) {
    _seriesDetailState = value;
    notifyListeners();
  }

  _setRecommendationState(RequestState value) {
    _seriesRecommendationState = value;
    notifyListeners();
  }
}

import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/domain/usecases/get_popular_series.dart';

class PopularSeriesNotifier extends ChangeNotifier {
  var _popularSeries = <Series>[];
  List<Series> get popularSeries => _popularSeries;

  RequestState _popularSeriesState = RequestState.Empty;
  RequestState get popularSeriesState => _popularSeriesState;

  var _currentMessage = '';
  String get currentMessage => _currentMessage;

  PopularSeriesNotifier({required this.getPopularSeries});
  final GetPopularSeries getPopularSeries;

  Future<void> fetchPopularSeries() async {
    _setPopularSeriesState(RequestState.Loading);
    final result = await getPopularSeries.execute();
    result.fold((failure) {
      _currentMessage = failure.message;
      notifyListeners();
      _setPopularSeriesState(RequestState.Error);
    }, (seriesData) {
      debugPrint('Popular Series Length ${seriesData.length}');
      _popularSeries = seriesData;
      notifyListeners();
      _setPopularSeriesState(RequestState.Loaded);
    });
  }

  _setPopularSeriesState(RequestState value) {
    _popularSeriesState = value;
    notifyListeners();
  }
}

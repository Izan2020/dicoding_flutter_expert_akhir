import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:tvseries/domain/usecases/get_top_rated_series.dart';
import '../../../domain/entities/series.dart';

class TopRatedSeriesNotifier extends ChangeNotifier {
  var _topRatedSeries = <Series>[];
  List<Series> get topRatedSeries => _topRatedSeries;

  RequestState _topRatedSeriesState = RequestState.Empty;
  RequestState get topRatedSeriesState => _topRatedSeriesState;

  var _currentMessage = '';
  String get currentMessage => _currentMessage;

  TopRatedSeriesNotifier({required this.getTopRatedSeries});
  final GetTopRatedSeries getTopRatedSeries;

  Future<void> fetchTopRatedSeries() async {
    _setTopRatedSeriesState(RequestState.Loading);
    final result = await getTopRatedSeries.execute();
    result.fold((failure) {
      _setTopRatedSeriesState(RequestState.Error);
      _currentMessage = failure.message;
      notifyListeners();
    }, (topRatedSeries) {
      _setTopRatedSeriesState(RequestState.Loaded);
      _topRatedSeries = topRatedSeries;
      notifyListeners();
    });
  }

  _setTopRatedSeriesState(RequestState value) {
    _topRatedSeriesState = value;
    notifyListeners();
  }
}

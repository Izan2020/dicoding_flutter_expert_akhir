import 'package:core/utils/state_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/domain/usecases/get_now_playing_series.dart';

class NowPlayingSeriesNotifier extends ChangeNotifier {
  final GetPlayingSeries getPlayingSeries;
  NowPlayingSeriesNotifier({required this.getPlayingSeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  var _listOfSeries = <Series>[];
  List<Series> get listOfSeries => _listOfSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchListOfPlayingSeries() async {
    _setState(RequestState.Loading);
    final result = await getPlayingSeries.execute();
    result.fold((failure) {
      _message = failure.message;
      _setState(RequestState.Error);
    }, (listOfSeries) {
      _listOfSeries = listOfSeries;
      notifyListeners();
      _setState(RequestState.Loaded);
    });
  }

  _setState(RequestState value) {
    _state = value;
    notifyListeners();
  }
}

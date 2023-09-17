import 'package:core/utils/state_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:tvseries/domain/usecases/get_now_playing_series.dart';
import 'package:tvseries/domain/usecases/get_popular_series.dart';
import 'package:tvseries/domain/usecases/get_top_rated_series.dart';

import '../../../domain/entities/series.dart';

class SeriesListNotifier extends ChangeNotifier {
  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  List<Series> _listOfNowPlaying = [];
  List<Series> get listOfNowPlaying => _listOfNowPlaying;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  List<Series> _listOfPopular = [];
  List<Series> get listOfPopular => _listOfPopular;

  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  List<Series> _listOfTopRated = [];
  List<Series> get listOfTopRated => _listOfTopRated;

  String _currentMessage = "";
  String get currentMessage => _currentMessage;

  SeriesListNotifier(
      {required this.getPlayingSeries,
      required this.getPopularSeries,
      required this.getTopRatedSeries});

  final GetPlayingSeries getPlayingSeries;
  final GetPopularSeries getPopularSeries;
  final GetTopRatedSeries getTopRatedSeries;

  Future<void> fetchPlayingSeries() async {
    _setNowPlayingState(RequestState.Loading);
    final result = await getPlayingSeries.execute();
    result.fold((failure) {
      _currentMessage = failure.message;
      notifyListeners();
      _setNowPlayingState(RequestState.Error);
    }, (success) {
      _listOfNowPlaying = success;
      notifyListeners();
      _setNowPlayingState(RequestState.Loaded);
    });
  }

  Future<void> fetchPopularSeries() async {
    _setPopularState(RequestState.Loading);
    final result = await getPopularSeries.execute();
    result.fold((failure) {
      _currentMessage = failure.message;
      notifyListeners();
      _setPopularState(RequestState.Error);
    }, (success) {
      _listOfPopular = success;
      notifyListeners();
      _setPopularState(RequestState.Loaded);
    });
  }

  Future<void> fetchTopRatedSeries() async {
    _setTopRatedState(RequestState.Loading);
    final result = await getTopRatedSeries.execute();
    result.fold((failure) {
      _currentMessage = failure.message;
      notifyListeners();
      _setTopRatedState(RequestState.Error);
    }, (result) {
      _listOfTopRated = result;
      notifyListeners();
      _setTopRatedState(RequestState.Loaded);
    });
  }

  _setNowPlayingState(RequestState value) {
    _nowPlayingState = value;
    notifyListeners();
  }

  _setPopularState(RequestState value) {
    _popularState = value;
    notifyListeners();
  }

  _setTopRatedState(RequestState value) {
    _topRatedState = value;
    notifyListeners();
  }
}

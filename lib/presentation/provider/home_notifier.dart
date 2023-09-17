import 'package:core/common/enums.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  HomeEvent _homeEvent = HomeEvent.Movies;
  HomeEvent get homeEvent => _homeEvent;

  Future<void> setHomeEvent(HomeEvent value) async {
    _homeEvent = value;
    notifyListeners();
  }
}

import 'package:ditonton/presentation/bloc/home/home_state.dart';

class HomeEvent {
  HomeEvent();
}

class OnSwitchHomeEvent extends HomeEvent {
  final HomeState homeState;
  OnSwitchHomeEvent(this.homeState);
}

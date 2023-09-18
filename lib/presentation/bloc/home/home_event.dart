import 'package:ditonton/presentation/bloc/home/home_state.dart';

class HomeEvent {
  HomeEvent();
}

class OnSwitchHomeEvent extends HomeEvent {
  final HomeStateValue homeState;
  OnSwitchHomeEvent(this.homeState);
}

import 'package:core/common/enums.dart';

class HomeEvent {
  HomeEvent();
}

class OnSwitchHomeEvent extends HomeEvent {
  final HomeStateValue homeState;
  OnSwitchHomeEvent(this.homeState);
}

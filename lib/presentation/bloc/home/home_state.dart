import 'package:core/common/enums.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final HomeStateValue homeStateValue;
  HomeState({this.homeStateValue = HomeStateValue.movies});

  @override
  List<Object?> get props => [homeStateValue];
}

import 'package:equatable/equatable.dart';

enum HomeStateValue { TvSeries, Movies }

class HomeState extends Equatable {
  final HomeStateValue homeStateValue;
  HomeState({this.homeStateValue = HomeStateValue.Movies});

  @override
  List<Object?> get props => [homeStateValue];
}

import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/series.dart';

class SeriesPopularState extends Equatable {
  const SeriesPopularState();

  @override
  List<Object?> get props => [];
}

class PSEOnInit extends SeriesPopularState {}

class PSEOnLoading extends SeriesPopularState {}

class PSEOnError extends SeriesPopularState {
  final String message;
  const PSEOnError(this.message);
  @override
  List<Object> get props => [message];
}

class PSEOnLoaded extends SeriesPopularState {
  final List<Series> listOfSeries;
  const PSEOnLoaded(this.listOfSeries);

  @override
  List<Object> get props => [listOfSeries];
}

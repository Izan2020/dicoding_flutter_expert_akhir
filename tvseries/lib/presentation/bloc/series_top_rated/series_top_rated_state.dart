import 'package:equatable/equatable.dart';
import 'package:tvseries/tvseries.dart';

class SeriesTopRatedState extends Equatable {
  const SeriesTopRatedState();
  @override
  List<Object?> get props => [];
}

class TRSOnInit extends SeriesTopRatedState {}

class TRSOnLoading extends SeriesTopRatedState {}

class TRSOnError extends SeriesTopRatedState {
  final String message;
  const TRSOnError(this.message);
}

class TRSOnLoaded extends SeriesTopRatedState {
  final List<Series> listOfSeries;
  const TRSOnLoaded(this.listOfSeries);
}

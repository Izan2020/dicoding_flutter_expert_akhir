import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/series.dart';

class SeriesNowPlayingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NPSOnInit extends SeriesNowPlayingState {}

class NPSOnLoading extends SeriesNowPlayingState {}

class NPSOnError extends SeriesNowPlayingState {
  final String message;
  NPSOnError(this.message);
}

class NPSOnLoaded extends SeriesNowPlayingState {
  final List<Series> listOfSeries;
  NPSOnLoaded(this.listOfSeries);
}

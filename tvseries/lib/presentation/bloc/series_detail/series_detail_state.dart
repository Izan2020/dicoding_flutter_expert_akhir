import 'package:equatable/equatable.dart';
import 'package:tvseries/tvseries.dart';

abstract class SeriesDetailState extends Equatable {
  const SeriesDetailState();
  @override
  List<Object?> get props => [];
}

class SDSOnEmpty extends SeriesDetailState {
  final String query;
  const SDSOnEmpty(this.query);

  @override
  List<Object?> get props => [query];
}

class SDSOnInit extends SeriesDetailState {}

class SDSOnError extends SeriesDetailState {
  final String message;
  const SDSOnError(this.message);
}

class SDSOnLoading extends SeriesDetailState {}

class SDSOnLoaded extends SeriesDetailState {
  final SeriesDetail loadedResult;
  const SDSOnLoaded(this.loadedResult);

  @override
  List<Object?> get props => [loadedResult];
}

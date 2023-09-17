import 'package:equatable/equatable.dart';

abstract class SeriesDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnFetchSeriesDetail extends SeriesDetailEvent {
  final int id;
  OnFetchSeriesDetail(this.id);

  @override
  List<Object?> get props => [id];
}

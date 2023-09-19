import 'package:equatable/equatable.dart';

abstract class SeriesDetailEvent extends Equatable {}

class OnFetchSeriesDetail extends SeriesDetailEvent {
  final int id;
  OnFetchSeriesDetail(this.id);

  @override
  List<Object?> get props => [id];
}

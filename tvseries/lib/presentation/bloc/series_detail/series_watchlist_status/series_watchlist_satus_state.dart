// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class SeriesWatchlistStatusState extends Equatable {
  final bool status;
  final String message;
  const SeriesWatchlistStatusState({this.status = false, this.message = ''});

  @override
  List<Object?> get props => [status, message];
}

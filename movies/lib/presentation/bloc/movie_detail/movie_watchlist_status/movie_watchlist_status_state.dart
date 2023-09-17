// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';

class MovieWatchlistStatusState extends Equatable {
  final bool status;
  final String message;
  MovieWatchlistStatusState({this.status = false, this.message = ''});

  @override
  List<Object?> get props => [status, message];
}

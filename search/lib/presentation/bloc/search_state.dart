import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnEmpty extends SearchState {
  final String query;
  OnEmpty(this.query);
}

class OnInit extends SearchState {}

class OnError extends SearchState {
  final String message;
  OnError(this.message);
}

class OnLoading extends SearchState {}

class OnLoaded extends SearchState {
  final List<Object> loadedResult;
  OnLoaded(this.loadedResult);
}

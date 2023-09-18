import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/bloc/home/home_event.dart';
import 'package:ditonton/presentation/bloc/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<OnSwitchHomeEvent>((event, emit) async {
      emit(HomeState(homeStateValue: event.homeState));
    });
  }
}

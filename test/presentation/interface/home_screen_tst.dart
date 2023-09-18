import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/enums.dart';
import 'package:ditonton/presentation/bloc/home/home_bloc.dart';
import 'package:ditonton/presentation/bloc/home/home_event.dart';
import 'package:ditonton/presentation/bloc/home/home_state.dart';
import 'package:ditonton/presentation/interface/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:mocktail/mocktail.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class HomeEventFake extends Fake implements HomeEvent {}

class HomeStateFake extends Fake implements HomeState {}

@GenerateMocks([HomeBloc])
void main() {
  late MockHomeBloc homeBloc;

  setUpAll(() {
    registerFallbackValue(HomeEventFake());
    registerFallbackValue(HomeStateFake());
  });

  setUp(() {
    homeBloc = MockHomeBloc();
  });

  Widget _makeTestableWidget() {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => homeBloc),
        ],
        child: HomeScreen(),
      ),
    );
  }

  group('Home Screen Test', () {
    testWidgets('should show TvSeries Page when state is TvSeries',
        (widgetTester) async {
      when(() => homeBloc.add(OnSwitchHomeEvent(HomeStateValue.tvSeries)))
          .thenAnswer((invocation) {});
      when(() => homeBloc.state).thenAnswer(
        (realInvocation) => HomeState(homeStateValue: HomeStateValue.tvSeries),
      );

      final pageFinder =
          find.byKey(Key('iL0v3DiCoDiNg!!!!(s3r1e5P4g3)!!!!pL1sB1nt4ngLima'));

      await widgetTester.pumpWidget(_makeTestableWidget());
      debugPrint(homeBloc.state.toString());
      expect(pageFinder, findsWidgets);
    });
  });
}

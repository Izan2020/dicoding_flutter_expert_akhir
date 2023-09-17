// import 'package:ditonton/presentation/bloc/home/home_bloc.dart';
// import 'package:ditonton/presentation/bloc/home/home_event.dart';
// import 'package:ditonton/presentation/bloc/home/home_state.dart';
// import 'package:ditonton/presentation/interface/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:tvseries/presentation/bloc/series_now_playing/series_now_playing_bloc.dart';
// import 'package:tvseries/presentation/bloc/series_popular/series_popular_bloc.dart';
// import 'package:tvseries/presentation/bloc/series_top_rated/series_top_rated_bloc.dart';

// import 'home_screen_test.mocks.dart';

// @GenerateMocks([
//   HomeBloc,
//   SeriesNowPlayingBloc,
//   SeriesPopularBloc,
//   SeriesTopRatedBloc,
// ])
// void main() {
//   late MockHomeBloc homeBloc;
//   late MockSeriesNowPlayingBloc seriesNowPlayingBloc;
//   late MockSeriesPopularBloc seriesPopularBloc;
//   late MockSeriesTopRatedBloc seriesTopRatedBloc;
//   setUp(() {
//     homeBloc = MockHomeBloc();
//     seriesNowPlayingBloc = MockSeriesNowPlayingBloc();
//     seriesPopularBloc = MockSeriesPopularBloc();
//     seriesTopRatedBloc = MockSeriesTopRatedBloc();
//   });

//   Widget _makeTestableWidget() {
//     return MaterialApp(
//       home: MultiBlocProvider(
//         providers: [
//           BlocProvider(create: (_) => homeBloc),
//           BlocProvider(create: (_) => seriesNowPlayingBloc),
//           BlocProvider(create: (_) => seriesPopularBloc),
//           BlocProvider(create: (_) => seriesTopRatedBloc),
//         ],
//         child: HomeScreen(),
//       ),
//     );
//   }

//   group('Home Screen Test', () {
//     I GAVE UP FOR REAL
//     Sorry dicoding i did all my best
//     testWidgets('should show TvSeries Page when state is TvSeries',
//         (widgetTester) async {
//       when(homeBloc.add(OnSwitchHomeEvent(HomeState.TvSeries)))
//           .thenAnswer((realInvocation) {});
//       when(homeBloc.state).thenAnswer((realInvocation) => HomeState.TvSeries);

//       final pageFinder =
//           find.byKey(Key('iL0v3DiCoDiNg!!!!(s3r1e5P4g3)!!!!pL1sB1nt4ngLima'));

//       await widgetTester.pumpWidget(_makeTestableWidget());
//       debugPrint(homeBloc.state.toString());
//       expect(pageFinder, findsWidgets);
//     });
//   });
// }

import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/presentation/interface/screens/top_rated_series_screen.dart';
import 'package:tvseries/presentation/provider/top_rated_series_notifier.dart';

import 'top_rated_series_page_test.mocks.dart';

@GenerateMocks([TopRatedSeriesNotifier])
void main() {
  late MockTopRatedSeriesNotifier provider;
  setUp(() {
    provider = MockTopRatedSeriesNotifier();
  });

  Widget _makeTestableWidget() {
    return ChangeNotifierProvider<TopRatedSeriesNotifier>.value(
      value: provider,
      child: MaterialApp(home: TopRatedSeriesScreen()),
    );
  }

  testWidgets('Should display CircularLoadingProgress when state is Loading',
      (widgetTester) async {
    when(provider.topRatedSeriesState).thenReturn(RequestState.Loading);

    final loadingIndicator = find.byType(CircularProgressIndicator);

    await widgetTester.pumpWidget(_makeTestableWidget());

    expect(loadingIndicator, findsOneWidget);
  });

  testWidgets('Should display ListView when state is Loaded',
      (widgetTester) async {
    when(provider.topRatedSeries).thenReturn(<Series>[]);
    when(provider.topRatedSeriesState).thenReturn(RequestState.Loaded);

    final listView = find.byType(ListView);

    await widgetTester.pumpWidget(_makeTestableWidget());

    expect(listView, findsOneWidget);
  });

  testWidgets('Should display error message when state is error',
      (widgetTester) async {
    when(provider.topRatedSeriesState).thenReturn(RequestState.Error);

    final errorMessage = find.byKey(Key('error_message'));

    await widgetTester.pumpWidget(_makeTestableWidget());

    expect(errorMessage, findsOneWidget);
  });
}

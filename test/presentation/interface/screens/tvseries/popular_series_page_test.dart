import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/presentation/interface/screens/popular_series_screen.dart';
import 'package:tvseries/presentation/provider/popular_series_notifier.dart';

import 'popular_series_page_test.mocks.dart';

@GenerateMocks([PopularSeriesNotifier])
void main() {
  late MockPopularSeriesNotifier provider;

  setUp(() {
    provider = MockPopularSeriesNotifier();
  });

  Widget _makeTestableWidget() {
    return ChangeNotifierProvider<PopularSeriesNotifier>.value(
      value: provider,
      child: MaterialApp(
        home: PopularSeriesScreen(),
      ),
    );
  }

  testWidgets('Should display CircularProgressIndicator', (tester) async {
    when(provider.popularSeriesState).thenReturn(RequestState.Loading);

    final loadingIndicator = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget());

    expect(loadingIndicator, findsOneWidget);
  });

  testWidgets('Should Display ListView when data is Loaded', (tester) async {
    when(provider.popularSeries).thenReturn(<Series>[]);
    when(provider.popularSeriesState).thenReturn(RequestState.Loaded);

    final listView = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget());

    expect(listView, findsOneWidget);
  });

  testWidgets('Should display error message when state is Error ',
      (tester) async {
    when(provider.popularSeriesState).thenReturn(RequestState.Error);

    final errorMessage = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget());

    expect(errorMessage, findsOneWidget);
  });
}

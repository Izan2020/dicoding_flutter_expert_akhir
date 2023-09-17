import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/presentation/interface/screens/series_detail_screen.dart';
import 'package:tvseries/presentation/provider/series_detail_notifier.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_page_test.mocks.dart';

@GenerateMocks([SeriesDetailNotifier])
void main() {
  late MockSeriesDetailNotifier provider;

  setUp(() {
    provider = MockSeriesDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<SeriesDetailNotifier>.value(
      value: provider,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  _assertWatchlist({bool isAddedToWatchlist = false, bool isFailed = false}) {
    final message = isFailed ? 'Failed' : 'Added to Watchlist';
    when(provider.seriesDetailState).thenReturn(RequestState.Loaded);
    when(provider.seriesDetail).thenReturn(testSeriesDetail);
    when(provider.seriesRecommendationState).thenReturn(RequestState.Loaded);
    when(provider.seriesRecommendations).thenReturn(<Series>[]);
    when(provider.isAddedToWatchlist).thenReturn(isAddedToWatchlist);
    when(provider.watchListSaveMessage).thenReturn(message);
  }

  group('Watchlist', () {
    testWidgets(
        'Watchlist button should display add icon when series isnt added to Watchlist',
        (tester) async {
      _assertWatchlist(isAddedToWatchlist: false);
      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(SeriesDetailScreen(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display check icon when series isnt added to Watchlist',
        (tester) async {
      _assertWatchlist(isAddedToWatchlist: true);
      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(SeriesDetailScreen(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets('Detail Screen should display Snackbar when added to watchlist',
        (tester) async {
      _assertWatchlist(isFailed: false);

      final watchlistButtonIcon = find.byIcon(Icons.add);
      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(SeriesDetailScreen(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    });

    testWidgets(
        'Detail screen should display AlertDialog when add to watchlist failed ',
        (tester) async {
      _assertWatchlist(isFailed: true);

      final watchlistButtonIcon = find.byIcon(Icons.add);
      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(SeriesDetailScreen(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    });
  });
}

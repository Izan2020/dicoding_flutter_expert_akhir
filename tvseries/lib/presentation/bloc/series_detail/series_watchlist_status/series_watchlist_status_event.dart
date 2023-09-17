import 'package:tvseries/tvseries.dart';

abstract class SeriesWatchlistStatusEvent {
  const SeriesWatchlistStatusEvent();
}

class OnLoadWatchlistStatus extends SeriesWatchlistStatusEvent {
  final int id;
  final String message;
  const OnLoadWatchlistStatus(this.id, this.message);
}

class OnNotifierTest extends SeriesWatchlistStatusEvent {
  final String test;
  const OnNotifierTest(this.test);
}

class OnSaveWatchlist extends SeriesWatchlistStatusEvent {
  final SeriesDetail series;
  const OnSaveWatchlist(this.series);
}

class OnRemoveWatchlist extends SeriesWatchlistStatusEvent {
  final SeriesDetail series;
  const OnRemoveWatchlist(this.series);
}

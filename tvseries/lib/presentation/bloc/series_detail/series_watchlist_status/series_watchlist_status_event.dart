import 'package:tvseries/tvseries.dart';

abstract class SeriesWatchlistStatusEvent {
  const SeriesWatchlistStatusEvent();
}

class OnLoadWatchlistStatus extends SeriesWatchlistStatusEvent {
  final int id;

  const OnLoadWatchlistStatus(this.id);
}

class OnSaveWatchlist extends SeriesWatchlistStatusEvent {
  final SeriesDetail series;
  const OnSaveWatchlist(this.series);
}

class OnRemoveWatchlist extends SeriesWatchlistStatusEvent {
  final SeriesDetail series;
  const OnRemoveWatchlist(this.series);
}

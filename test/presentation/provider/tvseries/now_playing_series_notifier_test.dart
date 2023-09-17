import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/domain/usecases/get_now_playing_series.dart';
import 'package:tvseries/presentation/provider/now_playing_series_notifier.dart';

import 'series_list_notifier_test.mocks.dart';

@GenerateMocks([GetPlayingSeries])
void main() {
  late MockGetPlayingSeries usecase;
  late NowPlayingSeriesNotifier provider;

  setUp(() {
    usecase = MockGetPlayingSeries();
    provider = NowPlayingSeriesNotifier(getPlayingSeries: usecase);
  });

  final tSerie = Series(
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originalName: 'Popular Series',
      overview: 'overview',
      popularity: 1.0,
      posterPath: 'posterPath',
      releaseDate: '12-12-2023',
      name: 'Reza Kecap - Jawa Ireng Returns',
      voteAverage: 12,
      voteCount: 12);

  final tSeriesList = <Series>[tSerie, tSerie];

  _assert(RequestState state) {
    switch (state) {
      case RequestState.Empty:
        // Nothing to Do.
        break;
      case RequestState.Loading:
        when(usecase.execute())
            .thenAnswer((realInvocation) async => Right(tSeriesList));
        break;
      case RequestState.Loaded:
        when(usecase.execute())
            .thenAnswer((realInvocation) async => Right(tSeriesList));
        break;
      case RequestState.Error:
        when(usecase.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
    }
  }

  group('Get Playing Series', () {
    test('should change state to loading before execute usecase', () {
      _assert(RequestState.Loading);
      provider.fetchListOfPlayingSeries();
      expect(provider.state, RequestState.Loading);
    });
    test('should update list data when usecase is executed successfully',
        () async {
      _assert(RequestState.Loaded);
      await provider.fetchListOfPlayingSeries();
      expect(provider.listOfSeries, tSeriesList);
      expect(provider.state, RequestState.Loaded);
    });
    test('description', () async {
      _assert(RequestState.Error);
      await provider.fetchListOfPlayingSeries();
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
    });
  });
}

import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/domain/usecases/get_top_rated_series.dart';
import 'package:tvseries/presentation/provider/top_rated_series_notifier.dart';

import 'top_rated_series_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedSeries])
void main() {
  late TopRatedSeriesNotifier provider;
  late MockGetTopRatedSeries usecase;

  setUp(() {
    usecase = MockGetTopRatedSeries();
    provider = TopRatedSeriesNotifier(getTopRatedSeries: usecase);
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

  _assertSuccess() => when(usecase.execute())
      .thenAnswer((realInvocation) async => Right(tSeriesList));

  _assertError() => when(usecase.execute()).thenAnswer(
      (realInvocation) async => Left(ServerFailure('Server Failure')));

  group('Get Top Rated Series', () {
    test('should change state to loading before executing usecase', () {
      _assertSuccess();
      provider.fetchTopRatedSeries();
      expect(provider.topRatedSeriesState, RequestState.Loading);
    });
    test('should update data when data is gotten successfully', () async {
      _assertSuccess();
      await provider.fetchTopRatedSeries();
      expect(provider.topRatedSeries, tSeriesList);
    });
    test('should return as error when data is failed to retrieve', () async {
      _assertError();
      await provider.fetchTopRatedSeries();
      expect(provider.topRatedSeriesState, RequestState.Error);
      expect(provider.currentMessage, 'Server Failure');
    });
  });
}

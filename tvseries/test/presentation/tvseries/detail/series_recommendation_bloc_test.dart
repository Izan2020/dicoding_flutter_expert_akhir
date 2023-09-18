import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/domain/usecases/get_series_recommendation.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_recommendation/series_recommendation_bloc.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_recommendation/series_recommendation_event.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_recommendation/series_recommendation_state.dart';

import 'series_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetSeriesRecommendation])
void main() {
  late SeriesRecommendationBloc bloc;
  late MockGetSeriesRecommendation usecase;

  setUp(() {
    usecase = MockGetSeriesRecommendation();
    bloc = SeriesRecommendationBloc(getSeriesRecommendation: usecase);
  });

  final tSeries = Series(
      backdropPath: 'backdropPath',
      genreIds: const [1, 2, 3],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 2,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      name: 'name',
      voteAverage: 3,
      voteCount: 3);
  final tSeriesList = <Series>[tSeries];
  const tFailure = ServerFailure('Server Failure');
  const tId = 1;

  blocTest<SeriesRecommendationBloc, SeriesRecommendationState>(
    'Should return [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((realInvocation) async => Right(tSeriesList));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnFetchSeriesRecommendation(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => {const SRSOnLoading(), SRSOnLoaded(tSeriesList)},
  );

  blocTest<SeriesRecommendationBloc, SeriesRecommendationState>(
    'Should return [Loading, Error] when data is gotten successfully',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((realInvocation) async => const Left(tFailure));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnFetchSeriesRecommendation(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => {const SRSOnLoading(), SRSOnError(tFailure.message)},
    verify: (bloc) => verify(usecase.execute(tId)),
  );
}

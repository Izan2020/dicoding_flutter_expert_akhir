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

import 'series_recommendation_test.mocks.dart';

@GenerateMocks([GetSeriesRecommendation])
void main() {
  late MockGetSeriesRecommendation usecase;
  late SeriesRecommendationBloc bloc;
  setUp(() {
    usecase = MockGetSeriesRecommendation();
    bloc = SeriesRecommendationBloc(getSeriesRecommendation: usecase);
  });

  final tSeries = Series(
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
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

  final tId = 1;

  group('Get Series Recommendation', () {
    blocTest<SeriesRecommendationBloc, SeriesRecommendationState>(
      'should return as [OnLoading, OnLoaded] when data is gotten successfully',
      build: () {
        when(usecase.execute(tId)).thenAnswer((_) async => Right(tSeriesList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchSeriesRecommendation(tId)),
      expect: () => {SRSOnLoading(), SRSOnLoaded(tSeriesList)},
    );
    blocTest<SeriesRecommendationBloc, SeriesRecommendationState>(
      'should return as [OnLoading, OnError] when data is gotten un-successfully',
      build: () {
        when(usecase.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchSeriesRecommendation(tId)),
      expect: () => {SRSOnLoading(), SRSOnError('Server Failure')},
    );
  });
}

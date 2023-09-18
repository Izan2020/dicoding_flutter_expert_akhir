import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/domain/usecases/get_top_rated_series.dart';
import 'package:tvseries/presentation/bloc/series_top_rated/series_top_rated_bloc.dart';
import 'package:tvseries/presentation/bloc/series_top_rated/series_top_rated_event.dart';
import 'package:tvseries/presentation/bloc/series_top_rated/series_top_rated_state.dart';

import 'top_rated_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedSeries])
void main() {
  late MockGetTopRatedSeries usecase;
  late SeriesTopRatedBloc bloc;
  setUp(() {
    usecase = MockGetTopRatedSeries();
    bloc = SeriesTopRatedBloc(getTopRatedSeries: usecase);
  });

  final tSeries = Series(
      backdropPath: 'backdropPath',
      genreIds: const [1, 2, 3],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 12,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      name: 'name',
      voteAverage: 12,
      voteCount: 123124);
  final tSeriesList = <Series>[tSeries];

  group('Get Top Rated Series', () {
    blocTest<SeriesTopRatedBloc, SeriesTopRatedState>(
      'should return as [TRSOnLoading, TRSOnLoaded] when data is gotten Successfully',
      build: () {
        when(usecase.execute())
            .thenAnswer((realInvocation) async => Right(tSeriesList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedSeries()),
      expect: () => {TRSOnLoading(), TRSOnLoaded(tSeriesList)},
    );
    blocTest<SeriesTopRatedBloc, SeriesTopRatedState>(
      'should return as [TRSOnLoading, TRSOnError] when data is gotten Un-Successfully',
      build: () {
        when(usecase.execute()).thenAnswer(
            (realInvocation) async => const Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedSeries()),
      expect: () => {TRSOnLoading(), const TRSOnError('Server Failure')},
    );
  });
}

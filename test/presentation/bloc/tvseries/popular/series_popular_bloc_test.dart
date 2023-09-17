import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/necessary_usecases.dart';
import 'package:tvseries/presentation/bloc/series_popular/series_popular_bloc.dart';
import 'package:tvseries/presentation/bloc/series_popular/series_popular_event.dart';
import 'package:tvseries/presentation/bloc/series_popular/series_popular_state.dart';

import 'series_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularSeries])
void main() {
  late MockGetPopularSeries usecase;
  late SeriesPopularBloc bloc;
  setUp(() {
    usecase = MockGetPopularSeries();
    bloc = SeriesPopularBloc(getPopularSeries: usecase);
  });

  final tSeries = Series(
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
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

  group('Get Popular Series', () {
    blocTest<SeriesPopularBloc, SeriesPopularState>(
      'should update state when data is gotten successfully from usecase',
      build: () {
        when(usecase.execute())
            .thenAnswer((realInvocation) async => Right(tSeriesList));
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(OnFetchPopularSeries()),
      expect: () => {PSEOnLoading(), PSEOnLoaded(tSeriesList)},
    );

    blocTest<SeriesPopularBloc, SeriesPopularState>(
      'should return as failed when data from usecase is gotten un-successfully',
      build: () {
        when(usecase.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(OnFetchPopularSeries()),
      expect: () => {PSEOnLoading(), PSEOnError('Server Failure')},
    );
  });
}

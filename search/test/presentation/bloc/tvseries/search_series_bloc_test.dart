import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecase/search_series.dart';
import 'package:search/presentation/bloc/search_event.dart';
import 'package:search/presentation/bloc/search_series/search_series_bloc.dart';
import 'package:search/presentation/bloc/search_state.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'search_series_bloc_test.mocks.dart';

@GenerateMocks([SearchSeries])
void main() {
  late MockSearchSeries usecase;
  late SearchSeriesBloc bloc;
  setUp(() {
    usecase = MockSearchSeries();
    bloc = SearchSeriesBloc(searchSeries: usecase);
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
  final tSeriesListEmpty = <Series>[];
  const tQuery = 'Spiderman';

  group('Get Series Search', () {
    blocTest<SearchSeriesBloc, SearchState>(
      'Should emit [Loading, OnLoaded] when data is gotten successfully',
      build: () {
        when(usecase.execute(tQuery))
            .thenAnswer((realInvocation) async => Right(tSeriesList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => {OnLoading(), OnLoaded(tSeriesList)},
      verify: (bloc) {
        verify(usecase.execute(tQuery));
      },
    );

    blocTest<SearchSeriesBloc, SearchState>(
      'Should emit [Loading, OnError] when data isnt successfully gotten',
      build: () {
        when(usecase.execute(tQuery)).thenAnswer(
            (realInvocation) async => const Left(ServerFailure('Failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => {OnLoading(), OnError('Failed')},
      verify: (bloc) => verify(usecase.execute(tQuery)),
    );
    blocTest<SearchSeriesBloc, SearchState>(
      'Should emit [Loading, OnEmpty] when data result is empty',
      build: () {
        when(usecase.execute(tQuery))
            .thenAnswer((realInvocation) async => Right(tSeriesListEmpty));
        return bloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => {OnLoading(), OnEmpty(tQuery)},
      verify: (bloc) => verify(usecase.execute(tQuery)),
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/necessary_usecases.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_detail_bloc.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_detail_event.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_detail_state.dart';

import '../../../../../test/dummy_data/dummy_objects.dart';
import 'series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetSeriesDetail])
void main() {
  late SeriesDetailBloc bloc;
  late MockGetSeriesDetail usecase;

  setUp(() {
    usecase = MockGetSeriesDetail();
    bloc = SeriesDetailBloc(getSeriesDetail: usecase);
  });

  final tSeriesDetail = testSeriesDetail;
  final tFailure = ServerFailure('Server Failure');
  final tId = 1;

  blocTest<SeriesDetailBloc, SeriesDetailState>(
    'Should emit [Loading, OnLoaded when data is gotten successfully]',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((realInvocation) async => Right(tSeriesDetail));
      return bloc;
    },
    act: (bloc) => bloc.add(OnFetchSeriesDetail(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => {SDSOnLoading(), SDSOnLoaded(tSeriesDetail)},
    verify: (bloc) => verify(usecase.execute(tId)),
  );

  blocTest<SeriesDetailBloc, SeriesDetailState>(
    'Should emit [Loading, OnError] when data is gotten unsuccessfully]',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((realInvocation) async => Left(tFailure));
      return bloc;
    },
    act: (bloc) => bloc.add(OnFetchSeriesDetail(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => {SDSOnLoading(), SDSOnError(tFailure.message)},
    verify: (bloc) => verify(usecase.execute(tId)),
  );
}

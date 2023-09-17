import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/necessary_usecases.dart';
import 'package:tvseries/presentation/bloc/series_now_playing/series_now_playing_bloc.dart';
import 'package:tvseries/presentation/bloc/series_now_playing/series_now_playing_event.dart';
import 'package:tvseries/presentation/bloc/series_now_playing/series_now_playing_state.dart';

import 'series_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetPlayingSeries])
void main() {
  late MockGetPlayingSeries usecase;
  late SeriesNowPlayingBloc bloc;
  setUp(() {
    usecase = MockGetPlayingSeries();
    bloc = SeriesNowPlayingBloc(getPlayingSeries: usecase);
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

  group('Get Now Playing Series', () {
    blocTest<SeriesNowPlayingBloc, SeriesNowPlayingState>(
      'should return [OnLoading, OnLoaded] when data is gotten succesfully',
      build: () {
        when(usecase.execute()).thenAnswer((_) async => Right(tSeriesList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlayingSeries()),
      expect: () => {
        NPSOnLoading(),
        NPSOnLoaded(tSeriesList),
      },
    );
    blocTest<SeriesNowPlayingBloc, SeriesNowPlayingState>(
      'should return [OnLoading, OnError] when data is gotten un-succesfully',
      build: () {
        when(usecase.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlayingSeries()),
      expect: () => {
        NPSOnLoading(),
        NPSOnError('Server Failure'),
      },
    );
  });
}

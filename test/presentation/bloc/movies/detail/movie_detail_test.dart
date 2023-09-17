import 'package:bloc_test/bloc_test.dart';
import 'package:core/necessary_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/necessary_usecases.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_state.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_detail_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MockGetMovieDetail usecase;
  late MovieDetailBloc bloc;
  setUp(() {
    usecase = MockGetMovieDetail();
    bloc = MovieDetailBloc(getMovieDetail: usecase);
  });

  final tId = 1231;

  group('Get Movie Detail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should return as [OnLoading, OnLoaded] when data is gotten successfully',
      build: () {
        when(usecase.execute(tId))
            .thenAnswer((realInvocation) async => Right(testMovieDetail));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieDetail(tId)),
      expect: () => {MDSOnLoading(), MDSOnLoaded(testMovieDetail)},
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should return as [OnLoading, OnError] when data is gotten un-successfully',
      build: () {
        when(usecase.execute(tId)).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieDetail(tId)),
      expect: () => {MDSOnLoading(), MDSOnError('Server Failure')},
    );
  });
}

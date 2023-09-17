import 'package:bloc_test/bloc_test.dart';
import 'package:core/necessary_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:movies/presentation/bloc/movie_now_playing/movie_now_playing_event.dart';
import 'package:movies/presentation/bloc/movie_now_playing/movie_now_playing_state.dart';

import 'movie_now_playing_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies usecase;
  late MovieNowPLayingBloc bloc;
  setUp(() {
    usecase = MockGetNowPlayingMovies();
    bloc = MovieNowPLayingBloc(getNowPlayingMovies: usecase);
  });

  final tMovie = Movie(
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originalTitle: 'originalName',
      overview: 'overview',
      popularity: 2,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      title: 'name',
      voteAverage: 3,
      voteCount: 3,
      adult: true,
      video: true);
  final tMovieList = <Movie>[tMovie];

  group('Get Now Playing Moview', () {
    blocTest<MovieNowPLayingBloc, MovieNowPlayingState>(
      'should return [OnLoading, OnLoaded] when data is gotten successfully',
      build: () {
        when(usecase.execute())
            .thenAnswer((realInvocation) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPLayingEvent()),
      expect: () => {MSPOnLoading(), MSPOnLoaded(tMovieList)},
    );
    blocTest<MovieNowPLayingBloc, MovieNowPlayingState>(
      'should return [OnLoading, OnError] when data is gotten un-successfully',
      build: () {
        when(usecase.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPLayingEvent()),
      expect: () => {MSPOnLoading(), MSPOnError('Server Failure')},
    );
  });
}

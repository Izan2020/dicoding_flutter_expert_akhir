import 'package:bloc_test/bloc_test.dart';
import 'package:core/necessary_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:movies/presentation/bloc/movie_popular/movie_popular_event.dart';
import 'package:movies/presentation/bloc/movie_popular/movie_popular_state.dart';

import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies usecase;
  late MoviePopularBloc bloc;
  setUp(() {
    usecase = MockGetPopularMovies();
    bloc = MoviePopularBloc(getPopularMovies: usecase);
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

  group('Get Popular Movies', () {
    blocTest<MoviePopularBloc, MoviePopularState>(
      'should return as [OnLoading, OnLoaded] when data is gotten successfully',
      build: () {
        when(usecase.execute())
            .thenAnswer((realInvocation) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularMoviesEvent()),
      expect: () => {MPSOnLoading(), MPSOnLoaded(tMovieList)},
    );
    blocTest<MoviePopularBloc, MoviePopularState>(
      'should return as [OnLoading, OnError] when data is gotten un-successfully',
      build: () {
        when(usecase.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularMoviesEvent()),
      expect: () => {MPSOnLoading(), MPSOnError('Server Failure')},
    );
  });
}

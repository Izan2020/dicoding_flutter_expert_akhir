import 'package:bloc_test/bloc_test.dart';
import 'package:core/necessary_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movies/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:movies/presentation/bloc/movie_top_rated/movie_top_rated_event.dart';
import 'package:movies/presentation/bloc/movie_top_rated/movie_top_rated_state.dart';

import 'movie_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MovieTopRatedBloc bloc;
  late MockGetTopRatedMovies usecase;
  setUp(() {
    usecase = MockGetTopRatedMovies();
    bloc = MovieTopRatedBloc(getTopRatedMovies: usecase);
  });

  final tMovie = Movie(
      backdropPath: 'backdropPath',
      genreIds: const [1, 2, 3],
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

  group('Get Top Rated Movies', () {
    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'should return [OnLoading, OnLoaded] when data is gotten successfully',
      build: () {
        when(usecase.execute())
            .thenAnswer((realInvocation) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedMovie()),
      expect: () => {MTROnLoading(), MTROnLoaded(tMovieList)},
    );

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'should return [OnLoading, OnError] when data is gotten un-successfully',
      build: () {
        when(usecase.execute()).thenAnswer((realInvocation) async =>
            const Left(ServerFailure('Servernya lagi sibuk ngab tunggu ntar ye')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedMovie()),
      expect: () => {
        MTROnLoading(),
        MTROnError('Servernya lagi sibuk ngab tunggu ntar ye')
      },
    );
  });
}

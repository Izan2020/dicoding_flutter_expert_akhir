import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:search/domain/usecase/search_movies.dart';
import 'package:search/presentation/bloc/search_event.dart';
import 'package:search/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:search/presentation/bloc/search_state.dart';

import 'movie_search_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MockSearchMovies usecase;
  late SearchMoviesBloc bloc;
  setUp(() {
    usecase = MockSearchMovies();
    bloc = SearchMoviesBloc(searchMovies: usecase);
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
  final tMovieListEmpty = <Movie>[];
  final tQuery = 'Spiderman';

  group('Get Movies Search', () {
    blocTest<SearchMoviesBloc, SearchState>(
      'should return as [OnLoading, OnLoaded] when data is gotten successfully',
      build: () {
        when(usecase.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      expect: () => {OnLoading(), OnLoaded(tMovieList)},
    );
    blocTest<SearchMoviesBloc, SearchState>(
      'should return as [OnLoading, OnError] when data is gotten un-successfully',
      build: () {
        when(usecase.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      expect: () => {OnLoading(), OnError('Server Failure')},
    );

    blocTest<SearchMoviesBloc, SearchState>(
      'should return as [OnLoading, OnEmpty] when data result is empty',
      build: () {
        when(usecase.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieListEmpty));
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      expect: () => {OnLoading(), OnEmpty(tQuery)},
    );
  });
}

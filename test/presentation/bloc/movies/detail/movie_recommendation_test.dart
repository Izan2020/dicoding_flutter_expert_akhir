import 'package:bloc_test/bloc_test.dart';
import 'package:core/necessary_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_recommendation/movie_recomendation_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_recommendation/movie_recomendation_event.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_recommendation/movie_recomendation_state.dart';

import 'movie_recommendation_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations usecase;
  late MovieRecommendationBloc bloc;
  setUp(() {
    usecase = MockGetMovieRecommendations();
    bloc = MovieRecommendationBloc(getMovieRecommendations: usecase);
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
  final tId = 1;

  group('Get Movie Recommendation', () {
    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'should return as [OnLoading, OnLoaded] when data is gotten succesfully',
      build: () {
        when(usecase.execute(tId))
            .thenAnswer((realInvocation) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieRecomendation(tId)),
      expect: () => {MRSOnLoading(), MRSOnLoaded(tMovieList)},
    );
    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'should return as [OnLoading, OnError] when data is gotten un-succesfully',
      build: () {
        when(usecase.execute(tId)).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieRecomendation(tId)),
      expect: () => {MRSOnLoading(), MRSOnError('Server Failure')},
    );
  });
}

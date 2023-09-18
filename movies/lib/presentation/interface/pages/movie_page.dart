import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:movies/presentation/bloc/movie_now_playing/movie_now_playing_event.dart';
import 'package:movies/presentation/bloc/movie_now_playing/movie_now_playing_state.dart';
import 'package:movies/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:movies/presentation/bloc/movie_popular/movie_popular_event.dart';
import 'package:movies/presentation/bloc/movie_popular/movie_popular_state.dart';
import 'package:movies/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:movies/presentation/bloc/movie_top_rated/movie_top_rated_event.dart';
import 'package:movies/presentation/bloc/movie_top_rated/movie_top_rated_state.dart';
import 'package:movies/presentation/interface/screens/movie_detail_screen.dart';
import '../../../domain/entities/movie.dart';
import '../screens/popular_movies_screen.dart';
import '../screens/top_rated_movies_screen.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  void initState() {
    context.read<MovieNowPLayingBloc>().add(OnFetchNowPLayingEvent());
    context.read<MoviePopularBloc>().add(OnFetchPopularMoviesEvent());
    context.read<MovieTopRatedBloc>().add(OnFetchTopRatedMovie());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Now Playing',
          style: kHeading6,
        ),
        BlocBuilder<MovieNowPLayingBloc, MovieNowPlayingState>(
            builder: ((context, state) {
          switch (state) {
            case MSPOnLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case MSPOnError():
              return Center(
                child: Text(state.message),
              );
            case MSPOnLoaded():
              return MovieList(state.listOfMovies);
            default:
              return Container();
          }
        })),
        _buildSubHeading(
          title: 'Popular',
          onTap: () =>
              Navigator.pushNamed(context, PopularMoviesScreen.ROUTE_NAME),
        ),
        BlocBuilder<MoviePopularBloc, MoviePopularState>(
            builder: ((context, state) {
          switch (state) {
            case MPSOnLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case MPSOnError():
              return Center(
                child: Text(state.message),
              );
            case MPSOnLoaded():
              return MovieList(state.listOfMovies);
            default:
              return Container();
          }
        })),
        _buildSubHeading(
          title: 'Top Rated',
          onTap: () => Navigator.pushNamed(
            context,
            TopRatedMoviesScreen.ROUTE_NAME,
          ),
        ),
        BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
            builder: ((context, state) {
          switch (state) {
            case MTROnLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case MTROnError():
              return Center(
                child: Text(state.message),
              );
            case MTROnLoaded():
              return MovieList(state.listOfMovies);
            default:
              return Container();
          }
        })),
      ],
    );
  }

  Widget _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailScreen.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/genre.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_state.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_recommendation/movie_recomendation_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_recommendation/movie_recomendation_event.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_recommendation/movie_recomendation_state.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_watchlist_status/movie_watchlist_status_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_watchlist_status/movie_watchlist_status_event.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_watchlist_status/movie_watchlist_status_state.dart';

class MovieDetailScreen extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  const MovieDetailScreen({super.key, required this.id});

  @override
  _MovieDetaiScreenState createState() => _MovieDetaiScreenState();
}

class _MovieDetaiScreenState extends State<MovieDetailScreen> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailBloc>().add(OnFetchMovieDetail(widget.id));
    context
        .read<MovieRecommendationBloc>()
        .add(OnFetchMovieRecomendation(widget.id));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    context
        .watch<MovieWatchlistStatusBloc>()
        .add(OnLoadWatchlistStatus(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
        switch (state) {
          case MDSOnLoading():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case MDSOnError():
            return Center(
              child: Text(state.message),
            );
          case MDSOnLoaded():
            return DetailContent(
              state.movieDetail,
              context.read<MovieWatchlistStatusBloc>().state.status,
            );
          default:
            return Container();
        }
      }),
    ));
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final bool isAddedWatchlist;
  const DetailContent(this.movie, this.isAddedWatchlist, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            BlocConsumer<MovieWatchlistStatusBloc,
                                    MovieWatchlistStatusState>(
                                listenWhen: (previous, current) =>
                                    current.message != '',
                                builder: (context, state) {
                                  return ElevatedButton(
                                    onPressed: () async {
                                      if (!isAddedWatchlist) {
                                        context
                                            .read<MovieWatchlistStatusBloc>()
                                            .add(OnSaveWatchlist(movie));
                                      } else {
                                        context
                                            .read<MovieWatchlistStatusBloc>()
                                            .add(OnRemoveWatchlist(movie));
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        isAddedWatchlist
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.add),
                                        const Text('Watchlist'),
                                      ],
                                    ),
                                  );
                                },
                                listener: (context, state) {
                                  final message = state.message;

                                  if (message ==
                                          MovieWatchlistStatusBloc
                                              .addSuccessMessage ||
                                      message ==
                                          MovieWatchlistStatusBloc
                                              .removeSuccessMessage) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(message)));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(message),
                                          );
                                        });
                                  }
                                }),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<MovieRecommendationBloc,
                                    MovieRecommendationState>(
                                builder: (context, state) {
                              switch (state) {
                                case MRSOnLoading():
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                case MRSOnError():
                                  return Center(child: Text(state.message));
                                case MRSOnLoaded():
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.listOfMovies.length,
                                      itemBuilder: (context, index) {
                                        final movie = state.listOfMovies[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailScreen.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                default:
                                  return Container();
                              }
                            })
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

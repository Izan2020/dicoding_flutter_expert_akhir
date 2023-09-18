// ignore_for_file: constant_identifier_names, library_private_types_in_public_api, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/genre.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tvseries/domain/entities/series_detail.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_detail_bloc.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_detail_event.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_detail_state.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_recommendation/series_recommendation_bloc.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_recommendation/series_recommendation_event.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_recommendation/series_recommendation_state.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_watchlist_status/series_watchlist_satus_state.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_watchlist_status/series_watchlist_status_bloc.dart';
import 'package:tvseries/presentation/bloc/series_detail/series_watchlist_status/series_watchlist_status_event.dart';

class SeriesDetailScreen extends StatefulWidget {
  static const ROUTE_NAME = '/series-detail';

  final int id;
  const SeriesDetailScreen({super.key, required this.id});

  @override
  _SeriesDetaiScreenState createState() => _SeriesDetaiScreenState();
}

class _SeriesDetaiScreenState extends State<SeriesDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SeriesDetailBloc>().add(OnFetchSeriesDetail(widget.id));
    context
        .read<SeriesRecommendationBloc>()
        .add(OnFetchSeriesRecommendation(widget.id));
    context
        .read<SeriesWatchlistStatusBloc>()
        .add(OnLoadWatchlistStatus(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SeriesDetailBloc, SeriesDetailState>(
        builder: (context, detailState) {
          switch (detailState) {
            case SDSOnLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case SDSOnError():
              return const Center(
                child: Text('Failed'),
              );
            case SDSOnLoaded():
              return SafeArea(
                  child: DetailContent(
                detailState.loadedResult,
                context.select(
                    (SeriesWatchlistStatusBloc value) => value.state.status),
              ));
            default:
              return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final SeriesDetail series;

  final bool isAddedWatchlist;

  const DetailContent(this.series, this.isAddedWatchlist, {super.key});

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${widget.series.posterPath}',
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
                              widget.series.name,
                              style: kHeading5,
                            ),
                            BlocConsumer<SeriesWatchlistStatusBloc,
                                    SeriesWatchlistStatusState>(
                                listenWhen: (before, after) =>
                                    after.message != '',
                                builder: (context, state) {
                                  return ElevatedButton(
                                    onPressed: () async {
                                      if (!widget.isAddedWatchlist) {
                                        context
                                            .read<SeriesWatchlistStatusBloc>()
                                            .add(
                                                OnSaveWatchlist(widget.series));
                                      } else {
                                        context
                                            .read<SeriesWatchlistStatusBloc>()
                                            .add(OnRemoveWatchlist(
                                                widget.series));
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        widget.isAddedWatchlist
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
                                          SeriesWatchlistStatusBloc
                                              .addSuccessMessage ||
                                      message ==
                                          SeriesWatchlistStatusBloc
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
                              _showGenres(widget.series.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.series.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.series.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.series.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<SeriesRecommendationBloc,
                                SeriesRecommendationState>(
                              builder: (context, state) {
                                switch (state) {
                                  case SRSOnLoading():
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  case SRSOnLoaded():
                                    return SizedBox(
                                      height: 150,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final series = state
                                              .seriesRecommendations[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  SeriesDetailScreen.ROUTE_NAME,
                                                  arguments: series.id,
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      'https://image.tmdb.org/t/p/w500${series.posterPath}',
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount:
                                            state.seriesRecommendations.length,
                                      ),
                                    );
                                  case SRSOnError():
                                    return const Center(
                                      child: Text('Failed'),
                                    );
                                  default:
                                    return Container();
                                }
                              },
                            )
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
}

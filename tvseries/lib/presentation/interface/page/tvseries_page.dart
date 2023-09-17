import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/presentation/bloc/series_now_playing/series_now_playing_bloc.dart';
import 'package:tvseries/presentation/bloc/series_now_playing/series_now_playing_event.dart';
import 'package:tvseries/presentation/bloc/series_now_playing/series_now_playing_state.dart';
import 'package:tvseries/presentation/bloc/series_popular/series_popular_bloc.dart';
import 'package:tvseries/presentation/bloc/series_popular/series_popular_event.dart';
import 'package:tvseries/presentation/bloc/series_popular/series_popular_state.dart';
import 'package:tvseries/presentation/bloc/series_top_rated/series_top_rated_bloc.dart';
import 'package:tvseries/presentation/bloc/series_top_rated/series_top_rated_event.dart';
import 'package:tvseries/presentation/bloc/series_top_rated/series_top_rated_state.dart';
import 'package:tvseries/presentation/interface/screens/now_playing_series_screen.dart';
import 'package:tvseries/presentation/interface/screens/popular_series_screen.dart';
import 'package:tvseries/presentation/interface/screens/series_detail_screen.dart';
import 'package:tvseries/presentation/interface/screens/top_rated_series_screen.dart';

class TvSeriesPage extends StatefulWidget {
  const TvSeriesPage({Key? key}) : super(key: key);

  @override
  State<TvSeriesPage> createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  @override
  void initState() {
    context.read<SeriesNowPlayingBloc>().add(OnFetchNowPlayingSeries());
    context.read<SeriesPopularBloc>().add(OnFetchPopularSeries());
    context.read<SeriesTopRatedBloc>().add(OnFetchTopRatedSeries());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubHeading(
            title: 'Now Playing',
            onTap: () => Navigator.pushNamed(
                  context,
                  NowPlayingSeriesScreen.ROUTE_NAME,
                )),
        BlocBuilder<SeriesNowPlayingBloc, SeriesNowPlayingState>(
            builder: (context, state) {
          switch (state) {
            case NPSOnLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case NPSOnLoaded():
              return SeriesList(state.listOfSeries);
            case NPSOnError():
              return Text(state.message);
            default:
              return Container();
          }
        }),
        _buildSubHeading(
            title: 'Popular',
            onTap: () =>
                Navigator.pushNamed(context, PopularSeriesScreen.ROUTE_NAME)),
        BlocBuilder<SeriesPopularBloc, SeriesPopularState>(
            builder: (context, state) {
          switch (state) {
            case PSEOnLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PSEOnLoaded():
              return SeriesList(state.listOfSeries);
            case PSEOnError():
              return Text(state.message);
            default:
              return Container();
          }
        }),
        _buildSubHeading(
            title: 'Top Rated',
            onTap: () =>
                Navigator.pushNamed(context, TopRatedSeriesScreen.ROUTE_NAME)),
        BlocBuilder<SeriesTopRatedBloc, SeriesTopRatedState>(
            builder: (context, state) {
          switch (state) {
            case TRSOnLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case TRSOnLoaded():
              return SeriesList(state.listOfSeries);
            case TRSOnError():
              return Text(state.message);
            default:
              return Container();
          }
        }),
      ],
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
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

class SeriesList extends StatelessWidget {
  final List<Series> seriesList;

  const SeriesList(this.seriesList, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final series = seriesList[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SeriesDetailScreen.ROUTE_NAME,
                  arguments: series.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${series.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: seriesList.length,
      ),
    );
  }
}

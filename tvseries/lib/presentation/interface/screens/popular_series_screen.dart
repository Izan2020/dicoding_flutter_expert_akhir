// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/bloc/series_now_playing/series_now_playing_bloc.dart';
import 'package:tvseries/presentation/bloc/series_now_playing/series_now_playing_state.dart';
import 'package:tvseries/presentation/widgets/series_card_list.dart';

class PopularSeriesScreen extends StatefulWidget {
  static const ROUTE_NAME = '/popular-series';

  const PopularSeriesScreen({super.key});

  @override
  State<PopularSeriesScreen> createState() => _PopularSeriesScreenState();
}

class _PopularSeriesScreenState extends State<PopularSeriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SeriesNowPlayingBloc, SeriesNowPlayingState>(
            builder: (context, state) {
          switch (state) {
            case NPSOnLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case NPSOnLoaded():
              return ListView.builder(
                  itemCount: state.listOfSeries.length,
                  itemBuilder: ((context, index) {
                    final series = state.listOfSeries[index];
                    return SeriesCard(series);
                  }));
            case NPSOnError():
              return Text(state.message);
            default:
              return Container();
          }
        }),
      ),
    );
  }
}

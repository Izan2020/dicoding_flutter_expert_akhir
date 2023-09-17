// ignore_for_file: constant_identifier_names

import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/search_event.dart';
import 'package:search/presentation/bloc/search_series/search_series_bloc.dart';
import 'package:search/presentation/bloc/search_state.dart';
import 'package:tvseries/domain/entities/series.dart';

import 'package:tvseries/presentation/widgets/series_card_list.dart';

class SearchSeriesScreen extends StatelessWidget {
  static const ROUTE_NAME = '/search-series';

  const SearchSeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) =>
                  context.read<SearchSeriesBloc>().add(OnQueryChanged(query)),
              decoration: const InputDecoration(
                hintText: 'Search name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchSeriesBloc, SearchState>(
                builder: (context, state) {
              switch (state) {
                case OnLoading():
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case OnLoaded():
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final series = state.loadedResult[index] as Series;
                        return SeriesCard(series);
                      },
                      itemCount: state.loadedResult.length,
                    ),
                  );
                case OnError():
                  return Center(
                    child: Text('Error ${state.message}'),
                  );
                case OnEmpty():
                  return Center(
                    child: Text(
                      'No results were found with \nkeyword "${state.query}" ',
                      textAlign: TextAlign.center,
                    ),
                  );
                default:
                  return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}


// Provider.of<SeriesSearchNotifier>(context, listen: false)
//     .fetchSearchSeries(query);

            // Consumer<SeriesSearchNotifier>(
            //   builder: (context, data, child) {
            //     if (data.state == RequestState.Loading) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (data.state == RequestState.Loaded) {
            //       final result = data.seriesResult;
            //       return Expanded(
            //         child: ListView.builder(
            //           padding: const EdgeInsets.all(8),
            //           itemBuilder: (context, index) {
            //             final series = data.seriesResult[index];
            //             return SeriesCard(series);
            //           },
            //           itemCount: result.length,
            //         ),
            //       );
            //     } else {
            //       return Expanded(
            //         child: Container(),
            //       );
            //     }
            //   },
            // ),
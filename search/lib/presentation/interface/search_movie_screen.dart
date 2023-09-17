// ignore_for_file: constant_identifier_names

import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';
import 'package:search/presentation/bloc/search_event.dart';
import 'package:search/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:search/presentation/bloc/search_state.dart';

class SearchMovieScreen extends StatefulWidget {
  static const ROUTE_NAME = '/search-movie';

  const SearchMovieScreen({super.key});

  @override
  State<SearchMovieScreen> createState() => _SearchMovieScreenState();
}

class _SearchMovieScreenState extends State<SearchMovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<SearchMoviesBloc>().add(
                      OnQueryChanged(query),
                    );
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
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
            BlocBuilder<SearchMoviesBloc, SearchState>(
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
                        final movies = state.loadedResult[index] as Movie;
                        return MovieCard(movies);
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
            })
          ],
        ),
      ),
    );
  }
}


            // Consumer<MovieSearchNotifier>(
            //   builder: (context, data, child) {
            //     if (data.state == RequestState.Loading) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (data.state == RequestState.Loaded) {
            //       final result = data.searchResult;
            //       return Expanded(
            //         child: ListView.builder(
            //           padding: const EdgeInsets.all(8),
            //           itemBuilder: (context, index) {
            //             final movie = data.searchResult[index];
            //             return MovieCard(movie);
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
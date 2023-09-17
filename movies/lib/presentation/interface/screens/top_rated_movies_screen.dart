// ignore_for_file: constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:movies/presentation/bloc/movie_top_rated/movie_top_rated_state.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';

class TopRatedMoviesScreen extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movies';

  const TopRatedMoviesScreen({super.key});

  @override
  _TopRatedMoviesScreenState createState() => _TopRatedMoviesScreenState();
}

class _TopRatedMoviesScreenState extends State<TopRatedMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
            builder: (context, state) {
          switch (state) {
            case MTROnLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case MTROnError():
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            case MTROnLoaded():
              return ListView.builder(
                itemCount: state.listOfMovies.length,
                itemBuilder: (context, index) {
                  final movie = state.listOfMovies[index];
                  return MovieCard(movie);
                },
              );
            default:
              return Container();
          }
        }),
      ),
    );
  }
}

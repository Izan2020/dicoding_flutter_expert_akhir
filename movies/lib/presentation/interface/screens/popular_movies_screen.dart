// ignore_for_file: library_private_types_in_public_api, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:movies/presentation/bloc/movie_popular/movie_popular_state.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';

class PopularMoviesScreen extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movies';

  const PopularMoviesScreen({super.key});

  @override
  _PopularMoviesScreenState createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoviePopularBloc, MoviePopularState>(
            builder: (context, state) {
          switch (state) {
            case MPSOnLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case MPSOnError():
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            case MPSOnLoaded():
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

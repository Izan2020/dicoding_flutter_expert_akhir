import 'package:core/utils/utils.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_event.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';
import 'package:tvseries/presentation/widgets/series_card_list.dart';

class WatchlistMoviesScreen extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesScreenState createState() => _WatchlistMoviesScreenState();
}

class _WatchlistMoviesScreenState extends State<WatchlistMoviesScreen>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistBloc>()
      ..add(OnLoadMovies())
      ..add(OnLoadSeries());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistBloc>()
      ..add(OnLoadMovies())
      ..add(OnLoadSeries());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Movies'),
              Tab(text: 'TV Series'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MoviesPage(),
            SeriesPage(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

class SeriesPage extends StatefulWidget {
  const SeriesPage({Key? key}) : super(key: key);

  @override
  State<SeriesPage> createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          BlocBuilder<WatchlistBloc, WatchlistState>(builder: (context, state) {
        final list = state.listOfSeries;
        if (list.isNotEmpty) {
          return ListView.builder(
            itemCount: state.listOfSeries.length,
            itemBuilder: (context, index) {
              final series = state.listOfSeries[index];
              return SeriesCard(series);
            },
          );
        } else {
          return Center(
            child: Text('Series Watchlist Empty'),
          );
        }
      }),
    );
  }
}

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          BlocBuilder<WatchlistBloc, WatchlistState>(builder: (context, state) {
        final list = state.listOfMovies;
        if (list.isNotEmpty) {
          return ListView.builder(
            itemCount: state.listOfMovies.length,
            itemBuilder: (context, index) {
              final movie = state.listOfMovies[index];
              return MovieCard(movie);
            },
          );
        } else {
          return Center(
            child: Text('Movies Watchlist Empty'),
          );
        }
      }),
    );
  }
}

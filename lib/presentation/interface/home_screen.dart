// ignore_for_file: sdk_version_since

import 'package:core/common/enums.dart';
import 'package:ditonton/presentation/bloc/home/home_bloc.dart';
import 'package:ditonton/presentation/bloc/home/home_event.dart';
import 'package:ditonton/presentation/bloc/home/home_state.dart';
import 'package:ditonton/presentation/interface/watchlist_ditonton_screen.dart';
import 'package:about/presentation/interface/about_screen.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tvseries/necessary_home.dart';
import 'package:movies/necessary_home.dart';
import 'package:search/necessary_home.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                context
                    .read<HomeBloc>()
                    .add(OnSwitchHomeEvent(HomeStateValue.movies));
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('TV Series'),
              onTap: () {
                context
                    .read<HomeBloc>()
                    .add(OnSwitchHomeEvent(HomeStateValue.tvSeries));
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesScreen.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                FirebaseCrashlytics.instance.crash();
              },
              leading: Icon(Icons.warning_amber_rounded),
              title: Text('Crashlytics Test'),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutScreen.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Text('Ditonton ${state.homeStateValue.name}');
          },
        ),
        actions: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  switch (state.homeStateValue) {
                    case HomeStateValue.movies:
                      Navigator.pushNamed(
                        context,
                        SearchMovieScreen.ROUTE_NAME,
                      );
                      break;
                    case HomeStateValue.tvSeries:
                      Navigator.pushNamed(
                        context,
                        SearchSeriesScreen.ROUTE_NAME,
                      );
                      break;
                  }
                },
                icon: Icon(Icons.search),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              switch (state.homeStateValue) {
                case HomeStateValue.movies:
                  return MoviePage(
                    key:
                        Key('iL0v3DiCoDiNg!!!!(m0vi3PaG3)!!!!aKuInGiNbInTanG5'),
                  );
                case HomeStateValue.tvSeries:
                  return TvSeriesPage(
                    key:
                        Key('iL0v3DiCoDiNg!!!!(s3r1e5P4g3)!!!!pL1sB1nt4ngLima'),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}

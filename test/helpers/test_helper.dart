import 'package:core/utils/ssl_pinning.dart';
import 'package:movies/data/datasources/db/movie_database_helper.dart';
import 'package:movies/data/datasources/movie_local_data_source.dart';
import 'package:movies/data/datasources/movie_remote_data_source.dart';
import 'package:movies/domain/repositories/movie_repository.dart';

import 'package:tvseries/data/datasource/series_local_data_source.dart';

import 'package:mockito/annotations.dart';
import 'package:tvseries/data/datasource/series_remote_data_source.dart';
import 'package:tvseries/domain/repositories/series_repository.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  MovieDatabaseHelper,
  SeriesRepository,
  SeriesRemoteDataSource,
  SeriesLocalDataSource,
], customMocks: [
  MockSpec<SSLCertifiedClient>(as: #MockSSLCertifiedClient)
])
void main() {}

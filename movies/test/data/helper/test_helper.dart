import 'package:core/utils/ssl_pinning.dart';
import 'package:movies/data/datasources/db/movie_database_helper.dart';
import 'package:movies/data/datasources/movie_local_data_source.dart';
import 'package:movies/data/datasources/movie_remote_data_source.dart';
import 'package:movies/domain/repositories/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:sqflite/sqflite.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  MovieDatabaseHelper,
  Database
], customMocks: [
  MockSpec<SSLCertifiedClient>(as: #MockSSLCertifiedClient)
])
void main() {}

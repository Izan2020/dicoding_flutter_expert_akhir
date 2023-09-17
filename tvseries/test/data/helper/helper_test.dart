import 'package:core/utils/ssl_pinning.dart';
import 'package:mockito/annotations.dart';
import 'package:tvseries/data/datasource/series_local_data_source.dart';
import 'package:tvseries/data/datasource/series_remote_data_source.dart';
import 'package:tvseries/domain/repositories/series_repository.dart';

@GenerateMocks([
  SeriesRepository,
  SeriesRemoteDataSource,
  SeriesLocalDataSource,
], customMocks: [
  MockSpec<SSLCertifiedClient>(as: #MockSSLCertifiedClient)
])
void main() {}

import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecase/get_watchlist_series.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/entities/series.dart';

import '../../../tvseries/test/data/helper/helper_test.mocks.dart';

void main() {
  late GetWatchlistSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetWatchlistSeries(mockSeriesRepository);
  });

  final tSeries = <Series>[];

  test('should get list of series watchlist from repository', () async {
    when(mockSeriesRepository.getWatchlistSeries())
        .thenAnswer((_) async => Right(tSeries));

    final result = await usecase.execute();

    expect(result, Right(tSeries));
  });
}

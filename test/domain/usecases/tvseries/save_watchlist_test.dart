import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/save_watchlist.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = SaveWatchlistSeries(mockSeriesRepository);
  });

  test('should save series to watchlist ', () async {
    when(mockSeriesRepository.saveWatchlist(testSeriesDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));

    final result = await usecase.execute(testSeriesDetail);

    expect(result, Right('Added to Watchlist'));
  });
}

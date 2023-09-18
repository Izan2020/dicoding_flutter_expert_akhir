import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/save_watchlist.dart';

import '../../data/helper/helper_test.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late SaveWatchlistSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = SaveWatchlistSeries(mockSeriesRepository);
  });

  test('should save series to watchlist ', () async {
    when(mockSeriesRepository.saveWatchlistSeries(testSeriesDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));

    final result = await usecase.execute(testSeriesDetail);

    expect(result, const Right('Added to Watchlist'));
  });
}

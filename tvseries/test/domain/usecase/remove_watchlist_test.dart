import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/remove_watchlist.dart';

import '../../data/helper/helper_test.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late RemoveWatchlistSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = RemoveWatchlistSeries(mockSeriesRepository);
  });

  test('should remove watchlist from repository', () async {
    when(mockSeriesRepository.removeWatchlist(testSeriesDetail))
        .thenAnswer((_) async => const Right('Deleted from watchlist'));

    final result = await usecase.execute(testSeriesDetail);

    expect(result, const Right('Deleted from watchlist'));
  });
}

import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/remove_watchlist.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = RemoveWatchlistSeries(mockSeriesRepository);
  });

  test('should remove watchlist from repository', () async {
    when(mockSeriesRepository.removeWatchlist(testSeriesDetail))
        .thenAnswer((_) async => Right('Deleted from watchlist'));

    final result = await usecase.execute(testSeriesDetail);

    expect(result, Right('Deleted from watchlist'));
  });
}

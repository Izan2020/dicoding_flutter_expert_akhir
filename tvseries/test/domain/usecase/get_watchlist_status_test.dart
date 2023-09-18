import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_watchlist_status_series.dart';

import '../../data/helper/helper_test.mocks.dart';

void main() {
  late GetWatchlistStatusSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetWatchlistStatusSeries(mockSeriesRepository);
  });

  const tId = 1;
  const tStatus = true;

  test('should get watchlist status', () async {
    when(mockSeriesRepository.isAddedToWatchlist(tId))
        .thenAnswer((_) async => tStatus);

    final result = await usecase.execute(tId);

    expect(result, tStatus);
  });
}

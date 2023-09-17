import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_watchlist_status_series.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistStatusSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetWatchlistStatusSeries(mockSeriesRepository);
  });

  final tId = 1;
  final tStatus = true;

  test('should get watchlist status', () async {
    when(mockSeriesRepository.isAddedToWatchlist(tId))
        .thenAnswer((_) async => tStatus);

    final result = await usecase.execute(tId);

    expect(result, tStatus);
  });
}

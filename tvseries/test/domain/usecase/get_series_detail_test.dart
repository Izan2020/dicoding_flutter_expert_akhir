import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_series_detail.dart';

import '../../data/helper/helper_test.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late MockSeriesRepository mockSeriesRepository;
  late GetSeriesDetail usecase;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetSeriesDetail(mockSeriesRepository);
  });

  final tId = 1;

  test('should get detail data', () async {
    when(mockSeriesRepository.getTvDetail(tId))
        .thenAnswer((_) async => Right(testSeriesDetail));

    final result = await usecase.execute(tId);

    expect(result, Right(testSeriesDetail));
  });
}

import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/domain/usecases/get_series_recommendation.dart';

import '../../data/helper/helper_test.mocks.dart';

void main() {
  late MockSeriesRepository mockSeriesRepository;
  late GetSeriesRecommendation usecase;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetSeriesRecommendation(mockSeriesRepository);
  });

  const tId = 1;
  final tSeries = <Series>[];

  test('should get list of series recommendation', () async {
    when(mockSeriesRepository.getSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(tSeries));

    final result = await usecase.execute(tId);

    expect(result, Right(tSeries));
  });
}

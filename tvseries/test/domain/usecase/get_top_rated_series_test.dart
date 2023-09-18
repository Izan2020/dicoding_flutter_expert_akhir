import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/domain/usecases/get_top_rated_series.dart';

import '../../data/helper/helper_test.mocks.dart';

void main() {
  late GetTopRatedSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetTopRatedSeries(mockSeriesRepository);
  });

  final tSeries = <Series>[];

  test('should get list of TopRated series', () async {
    when(mockSeriesRepository.getTopRatedSeries())
        .thenAnswer((_) async => Right(tSeries));

    final result = await usecase.execute();

    expect(result, Right(tSeries));
  });
}

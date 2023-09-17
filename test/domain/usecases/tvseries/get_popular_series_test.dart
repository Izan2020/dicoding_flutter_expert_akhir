import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/domain/usecases/get_popular_series.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetPopularSeries(mockSeriesRepository);
  });

  final tSeries = <Series>[];

  group('GetPopularSeries Tests', () {
    test('should get list of movies from repository', () async {
      when(mockSeriesRepository.getPopularTvs())
          .thenAnswer((_) async => Right(tSeries));
      final result = await usecase.execute();
      expect(result, Right(tSeries));
    });
  });
}

import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/domain/usecases/search_series.dart';
import '../../data/helper/helper_test.mocks.dart';

void main() {
  late SearchSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = SearchSeries(mockSeriesRepository);
  });

  final tQuery = 'Spiderman';
  final tResult = <Series>[];

  test('should show list of search query result', () async {
    when(mockSeriesRepository.searchTvs(tQuery))
        .thenAnswer((_) async => Right(tResult));

    final result = await usecase.execute(tQuery);

    expect(result, Right(tResult));
  });
}

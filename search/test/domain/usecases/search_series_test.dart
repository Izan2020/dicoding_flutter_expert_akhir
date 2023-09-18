import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:search/domain/usecase/search_series.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/necessary_usecases.dart';

import 'search_series_test.mocks.dart';

@GenerateMocks([SeriesRepository])
void main() {
  late SearchSeries usecase;
  late MockSeriesRepository repo;

  setUp(() {
    repo = MockSeriesRepository();
    usecase = SearchSeries(repo);
  });

  final tSeries = <Series>[];
  const tQuery = 'Spiderman';

  test('should get list of series from the repository', () async {
    // arrange
    when(repo.searchSeries(tQuery)).thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tSeries));
  });
}

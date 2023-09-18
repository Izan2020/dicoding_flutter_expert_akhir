import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/entities/series.dart';
import 'package:tvseries/domain/usecases/get_now_playing_series.dart';

import '../../data/helper/helper_test.mocks.dart';

void main() {
  late GetPlayingSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetPlayingSeries(mockSeriesRepository);
  });

  final tSeries = <Series>[];

  test('should get list of now playing series', () async {
    // arrange
    when(mockSeriesRepository.getNowPlayingSeries())
        .thenAnswer((_) async => Right(tSeries));

    // execute
    final result = await usecase.execute();

    expect(result, Right(tSeries));
  });
}

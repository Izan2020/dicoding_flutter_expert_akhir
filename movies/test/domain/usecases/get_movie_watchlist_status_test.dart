import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/necessary_usecases.dart';

import '../../data/helper/test_helper.mocks.dart';

void main() {
  late MockMovieRepository repository;
  late GetWatchListStatusMovie usecase;
  setUp(() {
    repository = MockMovieRepository();
    usecase = GetWatchListStatusMovie(repository);
  });

  const tId = 12421;

  group('Movie Watchlist Status Test', () {
    test('Should Return as false when data from usecase isnt found', () async {
      when(repository.isAddedToWatchlist(tId))
          .thenAnswer((realInvocation) async => false);

      final result = await usecase.execute(tId);

      expect(result, false);
    });
    test('Should Return as true when data from usecase is found', () async {
      when(repository.isAddedToWatchlist(tId))
          .thenAnswer((realInvocation) async => true);

      final result = await usecase.execute(tId);

      expect(result, true);
    });
  });
}

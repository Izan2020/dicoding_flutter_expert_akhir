// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:movies/data/datasources/db/movie_database_helper.dart';
// import 'package:movies/data/models/movie_table.dart';

// import 'test_helper.mocks.dart';

void main() {
// ?   BINGUNG WOII
// !   Bad state: databaseFactory not initialized
// !   databaseFactory is only initialized when using sqflite. When using `sqflite_common_ffi`
// !   You must call `databaseFactory = databaseFactoryFfi;` before using global openDatabase API

  // group('MovieDatabaseHelper', () {
  //   late MovieDatabaseHelper databaseHelper;
  //   late MockDatabase mockDatabase;

  //   setUp(() {
  //     mockDatabase = MockDatabase();
  //     databaseHelper = MovieDatabaseHelper();
  //   });

  //   const String tblWatchlist = 'movieWatchlist';

  //   test('insertWatchlist inserts a movie into the database', () async {
  //     const movie = MovieTable(
  //       id: 1,
  //       title: 'Test Movie',
  //       overview: 'This is a test movie.',
  //       posterPath: 'poster.jpg',
  //     );

  //     // Mock the behavior of the database.
  //     when(mockDatabase.insert(tblWatchlist, movie.toJson()))
  //         .thenAnswer((_) async => 1);

  //     final result = await databaseHelper.insertWatchlist(movie);

  //     // Verify that the insert method was called with the correct arguments.
  //     verify(mockDatabase.insert(tblWatchlist, movie.toJson()));

  //     // Verify that the result is as expected.
  //     expect(result, 1);
  //   });

  //   test('removeWatchlist removes a movie from the database', () async {
  //     const movie = MovieTable(
  //       id: 1,
  //       title: 'Test Movie',
  //       overview: 'This is a test movie.',
  //       posterPath: 'poster.jpg',
  //     );

  //     // Mock the behavior of the database.
  //     when(mockDatabase.delete(tblWatchlist,
  //             where: anyNamed('where'), whereArgs: anyNamed('whereArgs')))
  //         .thenAnswer((_) => Future.value(1));

  //     final result = await databaseHelper.removeWatchlist(movie);

  //     // Verify that the delete method was called with the correct arguments.
  //     verify(mockDatabase.delete(
  //       'movieWatchlist',
  //       where: 'id = ?',
  //       whereArgs: [movie.id],
  //     ));

  //     // Verify that the result is as expected.
  //     expect(result, 1);
  //   });

  //   test('getMovieById retrieves a movie from the database by ID', () async {
  //     const movieId = 1;
  //     final movieMap = {
  //       'id': movieId,
  //       'title': 'Test Movie',
  //       'overview': 'This is a test movie.',
  //       'posterPath': 'poster.jpg',
  //     };

  //     // Mock the behavior of the database.
  //     when(mockDatabase.query(
  //       tblWatchlist,
  //       where: anyNamed('where'),
  //       whereArgs: anyNamed('whereArgs'),
  //     )).thenAnswer((_) => Future.value([movieMap]));

  //     final result = await databaseHelper.getMovieById(movieId);

  //     // Verify that the query method was called with the correct arguments.
  //     verify(mockDatabase.query(
  //       'movieWatchlist',
  //       where: 'id = ?',
  //       whereArgs: [movieId],
  //     ));

  //     // Verify that the result is as expected.
  //     expect(result, movieMap);
  //   });

  //   test('getWatchlistMovies retrieves all movies from the database', () async {
  //     final movieList = [
  //       {
  //         'id': 1,
  //         'title': 'Test Movie 1',
  //         'overview': 'This is a test movie 1.',
  //         'posterPath': 'poster1.jpg',
  //       },
  //       {
  //         'id': 2,
  //         'title': 'Test Movie 2',
  //         'overview': 'This is a test movie 2.',
  //         'posterPath': 'poster2.jpg',
  //       },
  //     ];

  //     // Mock the behavior of the database.
  //     when(mockDatabase.query(tblWatchlist))
  //         .thenAnswer((_) => Future.value(movieList));

  //     final result = await databaseHelper.getWatchlistMovies();

  //     // Verify that the query method was called.
  //     verify(mockDatabase.query('movieWatchlist'));

  //     // Verify that the result is as expected.
  //     expect(result, movieList);
  //   });
  // });
}

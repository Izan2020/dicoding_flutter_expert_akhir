// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:tvseries/data/models/series_table.dart';

class SeriesDatabaseHelper {
  static SeriesDatabaseHelper? _SeriesDatabaseHelper;
  SeriesDatabaseHelper._instance() {
    _SeriesDatabaseHelper = this;
  }

  factory SeriesDatabaseHelper() =>
      _SeriesDatabaseHelper ?? SeriesDatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'seriesWatchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton_series.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT );
         ''');
  }

  Future<int> insertWatchlist(SeriesTable series) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, series.toJson());
  }

  Future<int> removeWatchlist(SeriesTable series) async {
    final db = await database;
    return await db!
        .delete(_tblWatchlist, where: 'id = ?', whereArgs: [series.id]);
  }

  Future<Map<String, dynamic>?> getSeriesbyId(int id) async {
    final db = await database;
    final results =
        await db!.query(_tblWatchlist, where: 'id = ?', whereArgs: [id]);
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }
}

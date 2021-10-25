import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    // final dbPath = await sql.getDatabasesPath();
    // final sqlDb = await sql.openDatabase(
    //   path.join(dbPath, 'places.db'),
    //   onCreate: (db, version) {
    //     return db.execute(
    //         'CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT)');
    //   },
    //   version: 1,
    // );
    //creates a new one if it doesnt find the table or opens an exxisting one
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
      //if we are inserting data for a pre existing id, then overwrites
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table); //get all data. returns list of maps
  }
}

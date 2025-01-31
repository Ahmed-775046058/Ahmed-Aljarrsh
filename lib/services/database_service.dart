import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/data_model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  Database? _database;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'data.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE data(id TEXT PRIMARY KEY, data TEXT, owner TEXT DEFAULT "أحمد الجراش")',
        );
      },
      version: 1,
    );
  }

  Future<void> insertData(DataModel data) async {
    final db = await database;
    await db.insert('data', data.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<DataModel>> getData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('data');

    return List.generate(maps.length, (i) {
      return DataModel(
        id: maps[i]['id'],
        data: maps[i]['data'],
      );
    });
  }

  Future<void> deleteData(String id) async {
    final db = await database;
    await db.delete('data', where: 'id = ?', whereArgs: [id]);
  }
}

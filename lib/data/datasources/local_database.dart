import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  // ✅ Singleton pattern: only one instance
  static final LocalDatabase instance = LocalDatabase._init();

  static Database? _database;

  // ✅ Private constructor
  LocalDatabase._init();

  // ✅ Getter to access database
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('attendly.db');
    return _database!;
  }

  // ✅ Initialize DB and create tables
  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // ✅ Create tables: users and absensi
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        password TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE absensi (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        type TEXT,
        timestamp TEXT,
        lat REAL,
        lng REAL,
        location TEXT
      )
    ''');
  }

  // ✅ Optional: Close DB (good practice)
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

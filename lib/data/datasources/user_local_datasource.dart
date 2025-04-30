import 'package:attendly_app/data/datasources/local_database.dart';
import 'package:sqflite/sqflite.dart';

class UserLocalDatasource {
  Future<Database> get _db async => await LocalDatabase.instance.database;

  /// ✅ Register user
  Future<int> registerUser(String name, String email, String password) async {
    final db = await _db;

    return await db.insert('users', {
      'name': name,
      'email': email,
      'password': password,
    });
  }

  /// ✅ Login user (match email & password)
  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final db = await _db;

    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  /// ✅ Get user by ID
  Future<Map<String, dynamic>?> getUserById(int userId) async {
    final db = await _db;

    final result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  /// ✅ Update user profile (name, email)
  Future<void> updateUser(int userId, String newName, String newEmail) async {
    final db = await _db;

    await db.update(
      'users',
      {'name': newName, 'email': newEmail},
      where: 'id = ?',
      whereArgs: [userId],
    );
  }
}

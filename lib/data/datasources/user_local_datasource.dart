import 'package:sqflite/sqflite.dart';
import 'local_database.dart';

class UserLocalDatasource {
  Future<int> registerUser(String name, String email, String password) async {
    final db = await LocalDatabase.database;
    return await db.insert('users', {
      'name': name,
      'email': email,
      'password': password,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final db = await LocalDatabase.database;
    final result = await db.query(
      'users',
      where: 'LOWER(email) = ? AND password = ?',
      whereArgs: [email.toLowerCase(), password],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = await LocalDatabase.database;
    final result = await db.query('users', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> updateUser(int id, String name, String email) async {
    final db = await LocalDatabase.database;
    return await db.update(
      'users',
      {'name': name, 'email': email},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

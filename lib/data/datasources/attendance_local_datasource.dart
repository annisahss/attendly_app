import 'package:attendly_app/data/datasources/local_database.dart';
import 'package:sqflite/sqflite.dart';


class AttendanceLocalDatasource {
  Future<Database> get _db async => await LocalDatabase.instance.database;

  Future<void> insertAttendance(Map<String, dynamic> data) async {
    final db = await _db;
    await db.insert('absensi', data);
  }

  Future<List<Map<String, dynamic>>> fetchAttendanceByUserId(int userId) async {
    final db = await _db;
    return await db.query(
      'absensi',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'timestamp DESC',
    );
  }

  Future<void> deleteAttendance(int id) async {
    final db = await _db;
    await db.delete('absensi', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> hasClockedInToday(int userId) async {
    final db = await _db;
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 1));

    final result = await db.query(
      'absensi',
      where: 'user_id = ? AND type = ? AND timestamp >= ? AND timestamp < ?',
      whereArgs: [
        userId,
        'masuk',
        start.toIso8601String(),
        end.toIso8601String(),
      ],
    );
    return result.isNotEmpty;
  }

  Future<bool> hasClockedOutToday(int userId) async {
    final db = await _db;
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 1));

    final result = await db.query(
      'absensi',
      where: 'user_id = ? AND type = ? AND timestamp >= ? AND timestamp < ?',
      whereArgs: [
        userId,
        'pulang',
        start.toIso8601String(),
        end.toIso8601String(),
      ],
    );
    return result.isNotEmpty;
  }
}

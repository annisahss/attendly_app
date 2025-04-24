
import 'local_database.dart';

class AttendanceLocalDatasource {
  Future<int> insertAttendance({
    required int userId,
    required String type,
    required String timestamp,
    double? latitude,
    double? longitude,
    String? location,
  }) async {
    final db = await LocalDatabase.database;
    return await db.insert('absensi', {
      'user_id': userId,
      'type': type,
      'timestamp': timestamp,
      'latitude': latitude,
      'longitude': longitude,
      'location': location,
    });
  }

  Future<List<Map<String, dynamic>>> getAttendanceHistory(int userId) async {
    final db = await LocalDatabase.database;
    return await db.query(
      'absensi',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'timestamp DESC',
    );
  }

  Future<int> deleteAttendance(int id) async {
    final db = await LocalDatabase.database;
    return await db.delete('absensi', where: 'id = ?', whereArgs: [id]);
  }
}

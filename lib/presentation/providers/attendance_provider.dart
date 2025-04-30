import 'package:flutter/material.dart';
import '../../data/datasources/attendance_local_datasource.dart';

class AttendanceProvider with ChangeNotifier {
  final AttendanceLocalDatasource _attendanceData = AttendanceLocalDatasource();

  List<Map<String, dynamic>> _attendanceList = [];

  List<Map<String, dynamic>> get attendanceList => _attendanceList;

  /// ✅ Add new attendance record (Clock In / Clock Out)
  Future<void> addAttendance({
    required int userId,
    required String type, // 'masuk' or 'pulang'
    required String timestamp,
    required double lat,
    required double lng,
    required String? location,
  }) async {
    await _attendanceData.insertAttendance({
      'user_id': userId,
      'type': type,
      'timestamp': timestamp,
      'lat': lat,
      'lng': lng,
      'location': location ?? 'Unknown location',
    });

    await fetchHistory(userId); // refresh after add
  }

  /// ✅ Get history by user
  Future<void> fetchHistory(int userId) async {
    final result = await _attendanceData.fetchAttendanceByUserId(userId);
    _attendanceList = result;
    notifyListeners();
  }

  /// ✅ Delete record
  Future<void> deleteAttendance(int id, int userId) async {
    await _attendanceData.deleteAttendance(id);
    await fetchHistory(userId); // refresh after delete
  }
}

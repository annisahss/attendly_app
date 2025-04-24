import 'package:flutter/material.dart';
import '../../data/datasources/attendance_local_datasource.dart';

class AttendanceProvider with ChangeNotifier {
  final AttendanceLocalDatasource _attendanceData = AttendanceLocalDatasource();
  List<Map<String, dynamic>> _attendanceList = [];

  List<Map<String, dynamic>> get attendanceList => _attendanceList;

  Future<void> fetchHistory(int userId) async {
    _attendanceList = await _attendanceData.getAttendanceHistory(userId);
    notifyListeners();
  }

  Future<void> addAttendance({
    required int userId,
    required String type,
    required String timestamp,
    double? lat,
    double? lng,
    String? location,
  }) async {
    await _attendanceData.insertAttendance(
      userId: userId,
      type: type,
      timestamp: timestamp,
      latitude: lat,
      longitude: lng,
      location: location,
    );
    await fetchHistory(userId); // Refresh list after insert
  }

  Future<void> deleteAttendance(int id, int userId) async {
    await _attendanceData.deleteAttendance(id);
    await fetchHistory(userId); // Refresh list after delete
  }
}

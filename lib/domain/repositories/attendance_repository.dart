import '../entities/attendance.dart';

abstract class AttendanceRepository {
  Future<void> saveAttendance(Attendance attendance);
  Future<List<Attendance>> fetchAttendance(int userId);
  Future<void> deleteAttendance(int id);
}

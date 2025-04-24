import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

class FetchAttendance {
  final AttendanceRepository repository;

  FetchAttendance(this.repository);

  Future<List<Attendance>> call(int userId) {
    return repository.fetchAttendance(userId);
  }
}

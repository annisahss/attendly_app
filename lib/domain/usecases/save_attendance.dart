import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

class SaveAttendance {
  final AttendanceRepository repository;

  SaveAttendance(this.repository);

  Future<void> call(Attendance attendance) {
    return repository.saveAttendance(attendance);
  }
}

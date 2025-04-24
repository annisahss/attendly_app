class Attendance {
  final int id;
  final int userId;
  final String type;
  final String timestamp;
  final double? latitude;
  final double? longitude;
  final String? location;

  Attendance({
    required this.id,
    required this.userId,
    required this.type,
    required this.timestamp,
    this.latitude,
    this.longitude,
    this.location,
  });
}

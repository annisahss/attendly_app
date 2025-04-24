class AttendanceModel {
  final int id;
  final int userId;
  final String type; // masuk / pulang
  final String timestamp;
  final double? latitude;
  final double? longitude;
  final String? location;

  AttendanceModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.timestamp,
    this.latitude,
    this.longitude,
    this.location,
  });

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      id: map['id'],
      userId: map['user_id'],
      type: map['type'],
      timestamp: map['timestamp'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      location: map['location'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'type': type,
      'timestamp': timestamp,
      'latitude': latitude,
      'longitude': longitude,
      'location': location,
    };
  }
}

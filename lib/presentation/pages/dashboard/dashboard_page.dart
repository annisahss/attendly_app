import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

import 'package:attendly_app/widgets/attendance_card.dart';
import 'package:attendly_app/widgets/custom_button.dart';
import 'package:attendly_app/widgets/map_widget.dart';
import 'package:attendly_app/core/services/location_service.dart';
import 'package:attendly_app/presentation/pages/profile/profile_page.dart';
import 'package:attendly_app/presentation/pages/history/attendance_history_page.dart';
import 'package:attendly_app/presentation/providers/auth_provider.dart';
import 'package:attendly_app/presentation/providers/attendance_provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Position? _position;
  String? _locationString;

  @override
  void initState() {
    super.initState();
    _getLocation();

    final auth = Provider.of<AuthProvider>(context, listen: false);
    if (auth.userId != null && auth.name == null) {
      auth.loadUserFromDatabase(auth.userId!);
    }
  }

  Future<void> _getLocation() async {
    final pos = await LocationService.getCurrentLocation();
    if (pos != null) {
      final address = await LocationService.getAddressFromLatLng(
        pos.latitude,
        pos.longitude,
      );
      setState(() {
        _position = pos;
        _locationString = address ?? 'Fetching location...';
      });
    }
  }

  String _getFormattedDate() {
    return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.now());
  }

  String _getFormattedTime() {
    final now = TimeOfDay.now();
    return now.format(context);
  }

  Future<void> _submitAttendance(String type) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final attendance = Provider.of<AttendanceProvider>(context, listen: false);

    if (_position == null) await _getLocation();
    if (_position == null) return;

    final now = DateTime.now();
    await attendance.addAttendance(
      userId: auth.userId!,
      type: type,
      timestamp: now.toIso8601String(),
      lat: _position!.latitude,
      lng: _position!.longitude,
      location: _locationString,
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Absen $type berhasil")));

    if (type == 'pulang' && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AttendanceHistoryPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const SizedBox(height: 32),

            // 👤 Profile Row (Avatar + Name + Title)
            Row(
              children: [
                GestureDetector(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ProfilePage()),
                      ),
                  child: const CircleAvatar(
                    radius: 32,
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      auth.name ?? "Loading...",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Software Engineer",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 💡 Motivation Text
            const Text(
              "Start your day with a positive mindset!",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.start,
            ),

            const SizedBox(height: 24),

            // 📅 Attendance Card (Time, Date, Map, Location)
            AttendanceCard(
              time: _getFormattedTime(),
              date: _getFormattedDate(),
              location: _locationString,
              map:
                  _position == null
                      ? const Center(child: CircularProgressIndicator())
                      : MapWidget(
                        latitude: _position!.latitude,
                        longitude: _position!.longitude,
                      ),
            ),

            const SizedBox(height: 24),

            // 🕒 Clock In / Clock Out Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () => _submitAttendance("masuk"),
                    child: const Text("Clock In"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () => _submitAttendance("pulang"),
                    child: const Text("Clock Out"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 📋 Attendance History Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEAF1FA),
                foregroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AttendanceHistoryPage(),
                    ),
                  ),
              child: const Text("Attendance History"),
            ),
          ],
        ),
      ),
    );
  }
}

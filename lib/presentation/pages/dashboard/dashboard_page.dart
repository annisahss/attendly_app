import 'package:attendly_app/core/constants/app_color.dart';
import 'package:attendly_app/data/datasources/attendance_local_datasource.dart';
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
  bool _isLoading = false;

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
    setState(() => _isLoading = true);

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

    setState(() => _isLoading = false);
  }

  String _getFormattedDate() {
    return DateFormat('EEEE, dd MMMM yyyy', 'en_US').format(DateTime.now());
  }

  String _getFormattedTime() {
    final now = TimeOfDay.now();
    return now.format(context);
  }

  Future<void> _submitAttendance(String type) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final attendance = Provider.of<AttendanceProvider>(context, listen: false);
    final dataSource = AttendanceLocalDatasource();

    if (_position == null) await _getLocation();
    if (_position == null) return;

    final now = DateTime.now();

    if (type == 'masuk') {
      final alreadyClockedIn = await dataSource.hasClockedInToday(auth.userId!);
      if (alreadyClockedIn) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You already clocked in today.")),
        );
        return;
      }
    }

    if (type == 'pulang') {
      final alreadyClockedIn = await dataSource.hasClockedInToday(auth.userId!);
      final alreadyClockedOut = await dataSource.hasClockedOutToday(
        auth.userId!,
      );

      if (!alreadyClockedIn) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You must clock in first.")),
        );
        return;
      }

      if (alreadyClockedOut) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You already clocked out today.")),
        );
        return;
      }
    }

    await attendance.addAttendance(
      userId: auth.userId!,
      type: type,
      timestamp: now.toIso8601String(),
      lat: _position!.latitude,
      lng: _position!.longitude,
      location: _locationString,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Clock ${type == 'masuk' ? 'In' : 'Out'} successful"),
      ),
    );

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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // 👤 App Bar and Profile Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back,",
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              isDarkMode
                                  ? AppColor.darkText
                                  : AppColor.lightText.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        auth.name ?? "Loading...",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:
                              isDarkMode
                                  ? AppColor.darkText
                                  : AppColor.lightText,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProfilePage(),
                          ),
                        ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              isDarkMode
                                  ? AppColor.darkAccent
                                  : AppColor.lightAccent,
                          width: 2,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage('assets/images/avatar.jpg'),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              const SizedBox(height: 12),

              // 📅 Attendance Card (Time, Date, Map, Location)
              Expanded(
                child: AttendanceCard(
                  time: _getFormattedTime(),
                  date: _getFormattedDate(),
                  location: _locationString,
                  map:
                      _position == null
                          ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  color:
                                      isDarkMode
                                          ? AppColor.darkAccent
                                          : AppColor.lightAccent,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "Getting your location...",
                                  style: TextStyle(
                                    color:
                                        isDarkMode
                                            ? AppColor.darkText.withOpacity(0.7)
                                            : AppColor.lightText.withOpacity(
                                              0.7,
                                            ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          : MapWidget(
                            latitude: _position!.latitude,
                            longitude: _position!.longitude,
                          ),
                  isDarkMode: isDarkMode,
                ),
              ),

              const SizedBox(height: 20),

              // 🕒 Clock In / Clock Out Buttons
              Row(
                children: [
                  CustomButton(
                    text: "Clock In",
                    color: AppColor.success,
                    isLoading: _isLoading,
                    onPressed: () => _submitAttendance("masuk"),
                    icon: Icons.login_rounded,
                  ),
                  const SizedBox(width: 16),
                  CustomButton(
                    text: "Clock Out",
                    color: AppColor.orange,
                    isLoading: _isLoading,
                    onPressed: () => _submitAttendance("pulang"),
                    icon: Icons.logout_rounded,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // 📋 Attendance History Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isDarkMode
                            ? AppColor.darkPrimary.withOpacity(0.3)
                            : AppColor.lightBlue,
                    foregroundColor:
                        isDarkMode ? AppColor.darkText : AppColor.lightPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AttendanceHistoryPage(),
                        ),
                      ),
                  icon: const Icon(Icons.history),
                  label: const Text("Attendance History"),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

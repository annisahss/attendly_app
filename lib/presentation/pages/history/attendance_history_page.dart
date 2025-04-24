import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/attendance_provider.dart';

class AttendanceHistoryPage extends StatefulWidget {
  const AttendanceHistoryPage({super.key});

  @override
  State<AttendanceHistoryPage> createState() => _AttendanceHistoryPageState();
}

class _AttendanceHistoryPageState extends State<AttendanceHistoryPage> {
  @override
  void initState() {
    super.initState();

    final auth = Provider.of<AuthProvider>(context, listen: false);
    if (auth.userId != null) {
      Provider.of<AttendanceProvider>(
        context,
        listen: false,
      ).fetchHistory(auth.userId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final history = Provider.of<AttendanceProvider>(context).attendanceList;

    if (auth.userId == null) {
      return const Scaffold(body: Center(child: Text("Please login first.")));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Attendance History")),
      body:
          history.isEmpty
              ? const Center(child: Text("No attendance history yet."))
              : ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final data = history[index];
                  final timestamp = DateTime.parse(data['timestamp']);
                  final date = DateFormat(
                    'EEEE, dd MMMM yyyy',
                    'id_ID',
                  ).format(timestamp);
                  final time = DateFormat('HH:mm').format(timestamp);
                  final location = data['location'] ?? 'Unknown location';
                  final type = data['type']; // 'masuk' or 'pulang'

                  final isCheckIn = type == 'masuk';

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading: Icon(
                        isCheckIn ? Icons.login : Icons.logout,
                        color: isCheckIn ? Colors.green : Colors.red,
                      ),
                      title: Text(
                        "${isCheckIn ? 'Check-In' : 'Check-Out'} • $time",
                      ),
                      subtitle: Text("$date\n$location"),
                      isThreeLine: true,
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          Provider.of<AttendanceProvider>(
                            context,
                            listen: false,
                          ).deleteAttendance(data['id'], data['user_id']);
                        },
                      ),
                    ),
                  );
                },
              ),
    );
  }
}

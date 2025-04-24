import 'package:flutter/material.dart';

class AttendanceCard extends StatelessWidget {
  final String time;
  final String date;
  final String? location;
  final Widget map;

  const AttendanceCard({
    super.key,
    required this.time,
    required this.date,
    required this.location,
    required this.map,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(time, style: Theme.of(context).textTheme.headlineMedium),
            Text(date, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 12),
            SizedBox(height: 250, width: double.infinity, child: map),
            const SizedBox(height: 8),
            Text(location ?? 'Fetching location...'),
          ],
        ),
      ),
    );
  }
}

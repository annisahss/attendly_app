import 'package:attendly_app/core/constants/app_color.dart';
import 'package:flutter/material.dart';

class AttendanceCard extends StatelessWidget {
  final String time;
  final String date;
  final String? location;
  final Widget map;
  final bool isDarkMode;

  const AttendanceCard({
    super.key,
    required this.time,
    required this.date,
    required this.location,
    required this.map,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: isDarkMode ? Colors.black38 : Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color:
              isDarkMode
                  ? AppColor.darkPrimary.withOpacity(0.2)
                  : AppColor.lightPrimary.withOpacity(0.1),
          width: 1,
        ),
      ),
      color: isDarkMode ? AppColor.darkCard : AppColor.lightCard,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Working Hours Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color:
                    isDarkMode
                        ? AppColor.darkAccent.withOpacity(0.15)
                        : AppColor.lightAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color:
                      isDarkMode
                          ? AppColor.darkAccent.withOpacity(0.3)
                          : AppColor.lightAccent.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.schedule_rounded,
                    color:
                        isDarkMode ? AppColor.darkAccent : AppColor.lightAccent,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Working Hours: 9:00 AM - 5:00 PM",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color:
                          isDarkMode
                              ? AppColor.darkAccent
                              : AppColor.lightAccent,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Date Section
            Text(
              date,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color:
                    isDarkMode
                        ? AppColor.darkText.withOpacity(0.7)
                        : AppColor.lightText.withOpacity(0.7),
              ),
            ),

            const SizedBox(height: 8),

            // Time Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  color:
                      isDarkMode ? AppColor.darkAccent : AppColor.lightAccent,
                  size: 28,
                ),
                const SizedBox(width: 8),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? AppColor.darkText : AppColor.lightText,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Map Section
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        isDarkMode
                            ? AppColor.darkPrimary.withOpacity(0.3)
                            : AppColor.lightPrimary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: map,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Location Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color:
                    isDarkMode
                        ? AppColor.darkPrimary.withOpacity(0.2)
                        : AppColor.lightBlue.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    color:
                        isDarkMode ? AppColor.darkAccent : AppColor.lightAccent,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      location ?? 'Fetching your location...',
                      style: TextStyle(
                        fontSize: 13,
                        color:
                            isDarkMode
                                ? AppColor.darkText.withOpacity(0.9)
                                : AppColor.lightText.withOpacity(0.9),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

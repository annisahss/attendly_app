import 'package:intl/intl.dart';

class DateFormatHelper {
  String formatDate(DateTime date) {
    return DateFormat('EEEE, dd MMMM yyyy', 'en_US').format(date);
  }

  String formatTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss a', 'en_US').format(dateTime);
  }
}

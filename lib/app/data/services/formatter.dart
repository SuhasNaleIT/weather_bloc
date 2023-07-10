import 'package:intl/intl.dart';

class Formatter {
  static String formatDate(String date) {
    String originalDateString = date;
    DateTime originalDate = DateTime.parse(originalDateString.substring(0, 10));
    final dateFormat = DateFormat('MMMMEEEEd');
    return dateFormat.format(originalDate);
  }

  static String formatImage(String text) {
    String weatherIcon = text.replaceAll(' ', '').toLowerCase() + ".png";
    return weatherIcon;
  }
}

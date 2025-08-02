import 'package:intl/intl.dart';

class DatetimeFormatter {
  // Menampilkan Jam
  static String formatHour(DateTime date) {
    return DateFormat.j().format(date);
  }

  // Menampilkan Tanggal dan Bulan
  static String formatDateMonth(DateTime date) {
    return DateFormat("d MMM").format(date);
  }
}

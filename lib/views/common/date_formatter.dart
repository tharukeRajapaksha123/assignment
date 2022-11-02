import 'package:intl/intl.dart';

class DateFormater {
  String dateFormater(DateTime date) {
    String formatted = DateFormat.MMMMEEEEd().format(DateTime.now());
    return formatted;
  }
}

String formatDate(DateTime date, [bool form = false]) {
  if (form) {
    return DateFormat("y-MM-dd").format(date);
  }
  return DateFormat.yMMMd().format(date);
}

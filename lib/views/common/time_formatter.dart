import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

TimeOfDay parseTime(String timeStr) {
  timeStr = timeStr.replaceAll(RegExp('\\s[A|P]M'), '');
  List<String> timeParts = timeStr.split(":");
  int hour = int.parse(timeParts[0]);
  int minute = int.parse(timeParts[1]);

  TimeOfDay time = TimeOfDay(hour: hour, minute: minute);
  return time;
}

String formatTime(TimeOfDay time, [bool form = false]) {
  DateTime dateTime = DateTime(0, 0, 0, time.hour, time.minute, 0, 0);

  if (form) {
    return DateFormat.Hms().format(dateTime);
  }
  return DateFormat.jm().format(dateTime);
}

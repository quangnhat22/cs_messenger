import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeExt {
  const DateTimeExt._();

  static const int weekStartDay = DateTime.saturday;

  static const String ddMMyyy = 'dd/MM/yyy';
  static const String hm = 'HH:mm';

  static String dateTimeToDisplay(
      {required DateTime? dateTime, String pattern = ddMMyyy}) {
    return dateTime != null
        ? DateFormat(pattern).format(dateTime)
        : '--/--/----';
  }

  static int getDaysRemaining({required DateTime? dateTime}) {
    if (dateTime == null) {
      return 0;
    }

    DateTime currentDate = DateTime.now().toLocal().toUtc().subtract(Duration(
        hours: DateTime.now().hour,
        minutes: DateTime.now().minute,
        seconds: DateTime.now().second,
        milliseconds: DateTime.now().millisecond,
        microseconds: DateTime.now().microsecond));

    DateTime inputDate = dateTime.toLocal().toUtc().subtract(Duration(
        hours: dateTime.hour,
        minutes: dateTime.minute,
        seconds: dateTime.second,
        milliseconds: dateTime.millisecond,
        microseconds: dateTime.microsecond));
    int daysDifference = inputDate.difference(currentDate).inDays;
    return inputDate.isAtSameMomentAs(currentDate) ? 0 : daysDifference;
  }

  static String timeToDisplay(
      {required DateTime? dateTime, String pattern = hm}) {
    return dateTime != null ? DateFormat(pattern).format(dateTime) : '--:--';
  }

  static String dateTimeRangeToDisplay(
      {required DateTimeRange? dateTimeRange, String pattern = ddMMyyy}) {
    return dateTimeRange != null
        ? '${dateTimeToDisplay(dateTime: dateTimeRange.start, pattern: pattern)} - ${dateTimeToDisplay(dateTime: dateTimeRange.end, pattern: pattern)}'
        : '--/--/---- - --/--/----';
  }

  static DateTime? stringToDate({required String? date}) {
    return date != null ? DateTime.tryParse(date) : null;
  }

  static int getWeekNumber({required DateTime date}) {
    const compensationFromSundayToWeekStartDay = (7 - weekStartDay) % 7;
    final jan1st = DateTime(date.year, 1, 1);
    final compensationFromJan1stToWeekStartDay =
        (jan1st.weekday + compensationFromSundayToWeekStartDay) % 7;
    final dateOfYear = int.parse(DateFormat("D").format(date));
    return ((dateOfYear + compensationFromJan1stToWeekStartDay - 1) / 7)
            .floor() +
        1;
  }

  static DateTime convertTimeStampToDateTime(int timeStamp) {
    return DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
  }
}

extension AppDateTime on DateTime {
  DateTime addExt(int days) => add(Duration(days: days));

  DateTime subtractExt(int days) => subtract(Duration(days: days));
}

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateTimeUtil {

  static const String formatDayMonthYearHourMinSec = "dd MMM yyyy hh:mm:ss a";
  static const String formatYearMonthDayHourMinSec = "yyyy-MM-dd HH:mm:ss";
  static const String formatWeekDayMonthYear = "EEEE, dd MMMM yyyy";
  static const String formatMMDDYYY = "MM/dd/yyyy";
  static const String formatHourMinAmPm = "hh:mm a";
  static const String formatDDMMYYY = "dd/MM/yyyy";
  static const String formatMMDD = "MM/dd";
  static const String formatMMM = "MMM";

  static DateTime convertDateToLocal(DateTime dateTime) {
    return DateTime.parse("$dateTime${"Z"}").toLocal();
  }

  static String getFormattedDate(DateTime? dateTime, {String format = formatDayMonthYearHourMinSec, bool localized = true, String? locale}) {
    try {
      return getFormattedDateTime(dateTime.toString(), format: format, localized : localized, locale: locale);
    } catch (_) {}
    return dateTime?.toString() ?? "";
  }

  static String getFormattedDateTime(String? dateTime, {String format = formatDayMonthYearHourMinSec, bool localized = true, String? locale}) {
    try {
      if (dateTime != null) {
        // I found this solution https://stackoverflow.com/questions/58322185/datetime-in-utc-not-converting-to-local
        // Adding Z to the date string is parsing and then converting it to proper local date time
        return DateFormat(format, locale).format(DateTime.parse("$dateTime${localized ? "Z" : ""}").toLocal());
      }
    } catch (_) {}
    return dateTime ?? "";
  }

  static String getPaymentFormattedDateForServer(DateTime dateTime) {
    return DateFormat(formatYearMonthDayHourMinSec).format(dateTime);
  }

  static DateTime addMonthsDateTime(DateTime dateTime, int months) {
    return (dateTime.isUtc)
        ? DateTime.utc(dateTime.year, dateTime.month + months, dateTime.day, dateTime.hour, dateTime.minute, dateTime.second, dateTime.millisecond)
        : DateTime(dateTime.year, dateTime.month + months, dateTime.day, dateTime.hour, dateTime.minute, dateTime.second, dateTime.millisecond);
  }

  static String getCurrentHourMin() {
    DateTime now = DateTime.now();
    return DateFormat(formatHourMinAmPm).format(now.toLocal());
  }

  static String getCurrentUTCDateTime() {
    return DateFormat(formatYearMonthDayHourMinSec).format(DateTime.timestamp());
  }

  static bool isSameMonthAndYear(DateTime firstDate, DateTime secondDate) {
    return firstDate.month == secondDate.month && firstDate.year == secondDate.year;
  }

  static bool isSameDay(DateTime firstDate, DateTime secondDate) {
    return firstDate.month == secondDate.month && firstDate.year == secondDate.year && firstDate.day == secondDate.day;
  }

  static bool isSameDayAndHour(DateTime firstDate, DateTime secondDate) {
    return firstDate.month == secondDate.month && firstDate.year == secondDate.year && firstDate.day == secondDate.day && firstDate.hour == secondDate.hour;
  }

  static PickerDateRange getDateRangeByType(String type) {
    final now = DateTime.now();
    DateTime start;
    DateTime end;

    switch (type) {
      case "today":
        start = end = DateTime(now.year, now.month, now.day);
        break;
      case "yesterday":
        final y = now.subtract(const Duration(days: 1));
        start = end = DateTime(y.year, y.month, y.day);
        break;
      case "last_week":
        final lastMonday = now.subtract(Duration(days: now.weekday + 6));
        start = DateTime(lastMonday.year, lastMonday.month, lastMonday.day);
        end = start.add(const Duration(days: 6));
        break;
      case "last_month":
        start = DateTime(now.year, now.month - 1, 1);
        end = DateTime(now.year, now.month, 0);
        break;
      case "last_quarter":
        final currentQuarter = ((now.month - 1) ~/ 3) + 1;
        final startMonth = (currentQuarter - 2) * 3 + 1;
        start = DateTime(now.year, startMonth, 1);
        end = DateTime(now.year, startMonth + 3, 0);
        break;
      default:
        start = now;
        end = now;
    }
    return PickerDateRange(start, end);
  }
}
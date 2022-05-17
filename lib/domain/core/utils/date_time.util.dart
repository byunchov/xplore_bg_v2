import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DateTimeUtils {
  static String yMMMMEEEEdFormat(DateTime dateTime, [String? locale]) {
    initializeDateFormatting();
    return DateFormat.yMMMMEEEEd(locale).format(dateTime);
  }

  static String yMMMMdFormat(DateTime dateTime, [String? locale]) {
    initializeDateFormatting();
    return DateFormat.yMMMMd(locale).format(dateTime);
  }

  static String yMEdHmFormat(DateTime dateTime, [String? locale]) {
    initializeDateFormatting();
    return DateFormat.yMEd(locale).add_jm().format(dateTime);
  }
}

import 'package:date_format/date_format.dart';

/// a simple converter + formater for the time and date, so it would be able to be saved in the database and viewed properlly
class DateTimeUtil {
  String dateToString(DateTime dateTime) {
    return (formatDate(
        dateTime, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]));
  }

  DateTime stringToDate(String string) {
    return DateTime.parse(string);
  }

  String time(DateTime time) {
    return formatDate(time, [HH, ':', nn, ' ', am]);
  }

  String date(DateTime date) {
    return formatDate(date, [yyyy, '/', mm, '/', dd]);
  }
  String formatStringDate(String string) {
   return (formatDate(stringToDate(string), [HH, ':', nn , ' ', yyyy, '/', mm, '/', dd]));
 }
}

final DateTimeUtil dateTimeUtil = DateTimeUtil();

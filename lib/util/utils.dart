
//  This package contains code to deal with internationalized/localized messages,
//  date and number parsing and other internalization issues.
import 'package:intl/intl.dart';

// this is a validation class with general rules
class Val {

  // validated if the given title has a value
  static String validateTitle(String val) {
    return (val != null && val != '') ? null : 'Title cannot be empty';
  }

  // given an string date, parses it, get the actual time
  // compare the difference between both and return the time to expire from now 
  static String getExpiryStr(String expires) {
    var e = DateUtils.convertToDate(expires);
    var td = new DateTime.now();

    Duration dif = e.difference(td);
    int dd = dif.inDays + 1;
    return (dd > 0) ? dd.toString() : "0";
  }

  static bool strToBool(String str) {
    return (int.parse(str) > 0) ? true : false;
  }

  static bool intToBool(int val) {
    return (val > 0) ? true : false;
  }

  static String boolToStr(bool val) {
    return (val == true) ? '1' : '0';
  }

  static int boolToInt(bool val) {
    return (val == true) ? 1 : 0;
  }

  

}

// this class is used to format and validate dates
class DateUtils {

  // try to convert a given date to yyyy-MM-dd format
  static DateTime convertToDate(String input) {
    try {
      var d = new DateFormat("yyyy-MM-dd").parseStrict(input);
      return d;
    } catch(e) {
      return null;
    }
  }

  // Remove whitespaces from date
  static String trimDate(String dt) {
    if (dt.contains(" ")) {
      List<String> p = dt.split(" ");
      return p[0];
    } else {
      return dt;
    }
  }

  // try to convert a given date to "day (month as text) year"
  static String convertToDateFull(String input) {
    try {
      var d = new DateFormat('yyyy-MM-dd').parseStrict(input);
      var formatter = new DateFormat('dd MMM yyyy');
      return formatter.format(d);
    } catch(e) {
      return null;
    }
  }

  static String convertToDateFullDt(DateTime input) {
    try {
      var formatter = new DateFormat('dd MMM yyyy');
      return formatter.format(input);
    } catch(e) {
      return null;
    }
  }

}
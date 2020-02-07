
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

}

// this class is used to format and validate dates
class DateUtils {

  // convert a given date to yyyy-MM-dd format
  static DateTime convertToDate(String input) {
    try {
      var d = new DateFormat("yyyy-MM-dd").parseStrict(input);
      return d;
    } catch(e) {
      return null;
    }
  }

}
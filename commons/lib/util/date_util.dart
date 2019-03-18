/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

part of commons;

class DateUtils {
  _DateUtils() {}

  static DateTime trimTime(DateTime dt) {
    if(dt.isUtc) {
      return new DateTime.utc(dt.year, dt.month, dt.day);
    } else {
      return new DateTime(dt.year, dt.month, dt.day);
    }
  }

  static var _daysInMonth = const [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  static bool _isLeapYear(int value) =>
      value % 400 == 0 || (value % 4 == 0 && value % 100 != 0);

  static int daysInMonth(int year, int month) {
    var result = _daysInMonth[month];
    if (month == 2 && _isLeapYear(year)) result++;
    return result;
  }

  static DateTime addMonths(DateTime dt, int value) {
    var r = value % 12;
    var q = (value - r) ~/ 12;
    var newYear = dt.year + q;
    var newMonth = dt.month + r;
    if (newMonth > 12) {
      newYear++;
      newMonth -= 12;
    }
    var newDay = min(dt.day, daysInMonth(newYear, newMonth));
    if (dt.isUtc) {
      return new DateTime.utc(newYear, newMonth, newDay, dt.hour, dt.minute,
          dt.second, dt.millisecond, dt.microsecond);
    } else {
      return new DateTime(newYear, newMonth, newDay, dt.hour, dt.minute,
          dt.second, dt.millisecond, dt.microsecond);
    }
  }

  static DateTime firstDayOfWeek(DateTime dt, int weekday) {
    int offsetWeekday = DateTime.sunday == weekday ? 0 : 1;
    int offset = -(dt.weekday == weekday ? 0 : dt.weekday - offsetWeekday);
    return dt.add(new Duration(days: offset));
  }

  static DateTime firstDayOfMonth(DateTime dt) {
    if (dt.isUtc) {
      return new DateTime.utc(dt.year, dt.month, 1, dt.hour, dt.minute,
          dt.second, dt.millisecond, dt.microsecond);
    } else {
      return new DateTime(dt.year, dt.month, 1, dt.hour, dt.minute,
          dt.second, dt.millisecond, dt.microsecond);
    }
  }


  // [ PHP ] ある月の第 3 日曜のような条件から日付を導出する – 行け！偏差値40プログラマー http://hensa40.cutegirl.jp/archives/1517
  static DateTime dayOfWeekInMonth(int year, int month, int times, int weekday) {
    // 指定年月の1日の日付
    var dt = new DateTime(year, month, 1);
    // 指定週の日 (1週目->1,2週目->8,3週目->15,4週目->22,4週目->29)
    var day = (times - 1) * 7 + 1;
    // 指定年月の1日の曜日と指定曜日の差
    var offset = weekday - dt.weekday;
    // 日を補正
    if (offset < 0) {
      day += offset + 7;
    } else {
      day += offset;
    }
    // 該当の日付
    var dayOfWeekInMonth = new DateTime(year, month, day);

    // 翌年/翌月の場合はnullを返す
    if (dayOfWeekInMonth.year > year || dayOfWeekInMonth.month > month) {
      return null;
    }

    return dayOfWeekInMonth;
  }

}

/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import "package:test/test.dart";
import "package:commons/commons.dart";
//import 'package:intl/intl.dart';

main() {
  group("trimTime()", () {
    test("returns time trimed DateTime", () {
      expect(DateUtils.trimTime(new DateTime(2020,2,29,12,12,12,12)), new DateTime(2020,2,29));
    });
  });

  group("addMonths()", () {
    test("returns last month", () {
      expect(DateUtils.addMonths(new DateTime(2020,2,29), -1), new DateTime(2020,1,29)); // うるう年
      expect(DateUtils.addMonths(new DateTime(2020,2,29), -12), new DateTime(2019,2,28)); // 1年前はうるう年ではない
      expect(DateUtils.addMonths(new DateTime(2020,1,28), -1), new DateTime(2019,12,28));
      expect(DateUtils.addMonths(new DateTime(2020,1,1), -1), new DateTime(2019,12,1));
      expect(DateUtils.addMonths(new DateTime(2018,1,1), -1), new DateTime(2017,12,1));
    });
  });

  group("firstDayOfWeek()", () {
    test("returns firstDayOfWeek DateTime", () {
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,3,31), DateTime.monday).weekday, DateTime.monday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,1), DateTime.monday).weekday, DateTime.monday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,2), DateTime.monday).weekday, DateTime.monday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,3), DateTime.monday).weekday, DateTime.monday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,4), DateTime.monday).weekday, DateTime.monday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,5), DateTime.monday).weekday, DateTime.monday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,6), DateTime.monday).weekday, DateTime.monday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,7), DateTime.monday).weekday, DateTime.monday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,8), DateTime.monday).weekday, DateTime.monday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,9), DateTime.monday).weekday, DateTime.monday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,10), DateTime.monday).weekday, DateTime.monday);

      expect(DateUtils.firstDayOfWeek(new DateTime(2018,3,31), DateTime.sunday).weekday, DateTime.sunday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,1), DateTime.sunday).weekday, DateTime.sunday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,2), DateTime.sunday).weekday, DateTime.sunday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,3), DateTime.sunday).weekday, DateTime.sunday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,4), DateTime.sunday).weekday, DateTime.sunday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,5), DateTime.sunday).weekday, DateTime.sunday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,6), DateTime.sunday).weekday, DateTime.sunday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,7), DateTime.sunday).weekday, DateTime.sunday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,8), DateTime.sunday).weekday, DateTime.sunday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,9), DateTime.sunday).weekday, DateTime.sunday);
      expect(DateUtils.firstDayOfWeek(new DateTime(2018,4,10), DateTime.sunday).weekday, DateTime.sunday);

      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,1), DateTime.monday));
      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,2), DateTime.monday));
      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,3), DateTime.monday));
      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,4), DateTime.monday));
      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,5), DateTime.monday));
      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,6), DateTime.monday));
      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,7), DateTime.monday));
      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,8), DateTime.monday));
      print(DateUtils.firstDayOfWeek(new DateTime(2018,5,1), DateTime.monday));
      print('---');
      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,1), DateTime.sunday));
      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,2), DateTime.sunday));
      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,3), DateTime.sunday));
      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,4), DateTime.sunday));
      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,5), DateTime.sunday));
      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,6), DateTime.sunday));
      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,7), DateTime.sunday));
      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,8), DateTime.sunday));
      print(DateUtils.firstDayOfWeek(new DateTime(2018,5,1), DateTime.sunday));
      print('---');
      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,1), DateTime.tuesday));
      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,2), DateTime.tuesday));
      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,3), DateTime.tuesday));
      print(DateUtils.firstDayOfWeek(new DateTime(2018,4,4), DateTime.tuesday));
    });
  });


  group("getDateFromWeekInfo()", () {
    test("returns dateFromWeek", () {
      // 成人の日（1月の第2月曜日）2018年1月08日(月)	成人の日
      print(DateUtils.dayOfWeekInMonth(2018,1,2,DateTime.monday));
      // 海の日（7月の第3月曜日）2018年7月16日(月)	海の日
      print(DateUtils.dayOfWeekInMonth(2018,7,3,DateTime.monday));
      // 敬老の日（9月の第3月曜日）2018年9月17日(月)	敬老の日
      print(DateUtils.dayOfWeekInMonth(2018,9,3,DateTime.monday));
      // 体育の日（10月の第2月曜日）2018年10月08日(月)	体育の日
      print(DateUtils.dayOfWeekInMonth(2018,10,2,DateTime.monday));

      var year = 2018;
      var month = 1;
      var times = 1;
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.sunday), new DateTime(2018,1,7));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.monday), new DateTime(2018,1,1));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.tuesday), new DateTime(2018,1,2));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.wednesday), new DateTime(year,1,3));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.thursday), new DateTime(year,1,4));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.friday), new DateTime(year,1,5));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.saturday), new DateTime(year,1,6));

      times = 2;
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.sunday), new DateTime(year,1,14));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.monday), new DateTime(year,1,8));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.tuesday), new DateTime(year,1,9));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.wednesday), new DateTime(year,1,10));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.thursday), new DateTime(year,1,11));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.friday), new DateTime(year,1,12));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.saturday), new DateTime(year,1,13));

      times = 5;
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.sunday), null);
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.monday), new DateTime(year,1,29));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.tuesday), new DateTime(year,1,30));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.wednesday), new DateTime(year,1,31));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.thursday), null);
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.friday), null);
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.saturday), null);

      month = 2; times = 2;
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.sunday), new DateTime(year,2,11));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.monday), new DateTime(year,2,12));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.tuesday), new DateTime(year,2,13));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.wednesday), new DateTime(year,2,14));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.thursday), new DateTime(year,2,8));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.friday), new DateTime(year,2,9));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.saturday), new DateTime(year,2,10));

      month = 4; times = 2;
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.sunday), new DateTime(year,month,8));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.monday), new DateTime(year,month,9));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.tuesday), new DateTime(year,month,10));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.wednesday), new DateTime(year,month,11));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.thursday), new DateTime(year,month,12));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.friday), new DateTime(year,month,13));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.saturday), new DateTime(year,month,14));

      month = 5; times = 1;
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.sunday), new DateTime(year,month,6));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.monday), new DateTime(year,month,7));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.tuesday), new DateTime(year,month,1));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.wednesday), new DateTime(year,month,2));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.thursday), new DateTime(year,month,3));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.friday), new DateTime(year,month,4));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.saturday), new DateTime(year,month,5));

      month = 5; times = 2;
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.sunday), new DateTime(year,month,13));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.monday), new DateTime(year,month,14));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.tuesday), new DateTime(year,month,8));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.wednesday), new DateTime(year,month,9));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.thursday), new DateTime(year,month,10));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.friday), new DateTime(year,month,11));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.saturday), new DateTime(year,month,12));

      month = 5; times = 4;
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.sunday), new DateTime(year,month,27));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.monday), new DateTime(year,month,28));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.tuesday), new DateTime(year,month,22));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.wednesday), new DateTime(year,month,23));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.thursday), new DateTime(year,month,24));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.friday), new DateTime(year,month,25));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.saturday), new DateTime(year,month,26));

      month = 9; times = 1;
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.sunday), new DateTime(year,month,2));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.monday), new DateTime(year,month,3));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.tuesday), new DateTime(year,month,4));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.wednesday), new DateTime(year,month,5));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.thursday), new DateTime(year,month,6));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.friday), new DateTime(year,month,7));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.saturday), new DateTime(year,month,1));

      month = 9; times = 5;
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.sunday), new DateTime(year,month,30));
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.monday), null);
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.tuesday), null);
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.wednesday), null);
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.thursday), null);
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.friday), null);
      expect(DateUtils.dayOfWeekInMonth(year,month,times,DateTime.saturday), new DateTime(year,month,29));

    });
  });
}
/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF0092CA);
const kPrimaryTextColor = Colors.white;
const kPrimaryBackgroundColor = Colors.white;
const kSecondaryBackgroundColor = Color(0xFFF5F5F5);

const kTextMainColor = Color(0xFF5B6E75);
const kTextSubColor = Color.fromRGBO(91, 110, 117, 0.7);
const kTextTitleColor = Color.fromRGBO(91, 110, 117, 0.7);

// Timetable color
const kTimetableHeaderBackgroundColor = Color(0xFFEDF2F4);
const kTimetableBorderColor = Color(0xFFE0EAEE);

class AppTheme {
  static get theme {
    final originalTextTheme = ThemeData.light().textTheme.apply(
        fontFamily: 'Montserrat',
        bodyColor: kTextMainColor,
        displayColor: kTextMainColor);

    return new ThemeData.light().copyWith(
      primaryColor: kPrimaryColor,
      accentColor: kPrimaryColor,

      primaryTextTheme: originalTextTheme.copyWith(
          title: originalTextTheme.title
              .copyWith(fontSize: 18.0, color: kPrimaryTextColor)),

      textTheme: originalTextTheme.copyWith(
        title: originalTextTheme.title,
        subhead: originalTextTheme.subhead.copyWith(color: kTextSubColor),
        body1: originalTextTheme.body1,
        body2: originalTextTheme.body2,
        caption: originalTextTheme.caption.copyWith(color: kTextSubColor),
      ),

    );
  }
}

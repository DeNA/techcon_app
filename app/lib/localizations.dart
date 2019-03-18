/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
//    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class AppLocalizations {
  final Locale locale;
  static Map<dynamic, dynamic> _localisedValues;

  AppLocalizations(this.locale);

  static Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appTranslations = AppLocalizations(locale);
    String jsonContent;
    try {
      jsonContent = await rootBundle.loadString("assets/locales/messages_${locale.languageCode}.json", cache: false);
    } catch (e) {
      jsonContent = await rootBundle.loadString("assets/locales/messages.json", cache: false);
    }
    _localisedValues = json.decode(jsonContent);
    return appTranslations;
  }

  get currentLocale => locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String text(String key) {
    // workaround
    if (_localisedValues == null) {
      return "$key not found";
    }
    return _localisedValues[key] ?? "$key not found";
  }

//  static Map<String, Map<String, String>> _localizedValues = {
//    'en': {
//      'title': 'DeNA TechCon',
//    },
//    'ja': {
//      'title': "DeNA TechCon",
//    },
//  };
//
//  String get title {
//    return _localizedValues[locale.languageCode]['title'];
//  }
}

/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'dart:async';

import 'package:app/features/about.dart';
import 'package:app/features/code_of_conduct.dart';
import 'package:app/features/home.dart';
import 'package:app/features/splash.dart';
import 'package:app/localizations.dart';
import 'package:app/routes.dart';
import 'package:app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:architecture/state.dart';
import 'package:architecture/middleware.dart';
import 'package:architecture/reducer.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:repository_cache/repository_cache.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:repository_local/repository_local.dart';

Future main() async {
  //  debugPaintSizeEnabled = true;
  //  debugPaintBaselinesEnabled = true;

  // flutter_crashlytics | Flutter Package https://pub.dartlang.org/packages/flutter_crashlytics
  bool isInDebugMode = false;

  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      // Crashlytics.
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  await FlutterCrashlytics().initialize();

  runZoned<Future<Null>>(() async {
    runApp(App());
  }, onError: (error, stackTrace) async {
    // Whenever an error occurs, call the `reportCrash` function. This will send
    // Dart errors to our dev console or Crashlytics depending on the environment.
    await FlutterCrashlytics().reportCrash(error, stackTrace, forceCrash: true);
  });
}

class App extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  static FirebaseMessaging messaging = FirebaseMessaging();

  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: createStoreMiddleware(RepositoryLocal()),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', 'US'), // English
          Locale('ja', 'JP'), // Japanese
        ],
        theme: AppTheme.theme,
        navigatorObservers: <NavigatorObserver>[observer],
        routes: <String, WidgetBuilder>{
          AppRoutes.splash: (_) => Splash(),
          AppRoutes.home: (_) => HomePage(
              analytics: analytics, observer: observer, messaging: messaging),
          AppRoutes.about: (_) => AboutPage(),
          AppRoutes.codeOfConduct: (_) => CodeOfConductPage(),
        },
        builder: (context, child) {
          // Disable larger font because the layout collapses.
          // - Android: Settings -> Display-> Font Size
          // - iOS: Settings -> General -> Accessibility -> Larger Text
          return MediaQuery(
            child: child,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          );
        },
      ),
    );
  }
}

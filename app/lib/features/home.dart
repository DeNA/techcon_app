/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'package:app/features/about.dart';
import 'package:app/features/enquete.dart';
import 'package:app/features/map.dart';
import 'package:app/features/menu.dart';
import 'package:app/features/sessions.dart';
import 'package:app/features/widget/backdrop.dart';
import 'package:app/localizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:architecture/actions.dart';
import 'package:architecture/active_tab.dart';
import 'package:architecture/app_tab.dart';
import 'package:architecture/state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomePage extends StatelessWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final FirebaseMessaging messaging;

  const HomePage({Key key, this.analytics, this.observer, this.messaging}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    messaging.configure();
    messaging.requestNotificationPermissions(
        const IosNotificationSettings(sound:true, badge: true, alert: true)
    );

    return StoreBuilder<AppState>(
//        onInit: (store) => store.dispatch(UpdateTabAction(AppTab.sessions)),
      builder: (context, store) {
        return ActiveTab(
          builder: (BuildContext context, AppTab activeTab) {
            return Backdrop(
              currentTab: activeTab,
              frontLayer: _createTab(activeTab, analytics, observer),
              backLayer: MenuPage(
                currentTab: activeTab,
                onTabTap: (tab) => store.dispatch(UpdateTabAction(tab)),
              ),
              frontTitle: Text(AppLocalizations.of(context).text("title_app")),
              backTitle: Text(AppLocalizations.of(context).text("menu")),
            );
          },
        );
      },
    );
  }

  Widget _createTab(AppTab activeTab, FirebaseAnalytics analytics,
      FirebaseAnalyticsObserver observer) {
    switch (activeTab) {
      case AppTab.sessions:
        return SessionsPage(analytics: analytics, observer: observer);
      case AppTab.map:
        return MapPage();
      case AppTab.about:
        return AboutPage(analytics: analytics, observer: observer);
      case AppTab.enquete:
        return EnquetePage();
      default:
        return SessionsPage(analytics: analytics, observer: observer);
    }
  }

}

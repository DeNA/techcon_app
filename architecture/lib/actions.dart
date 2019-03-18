/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'package:architecture/app_tab.dart';
import 'package:repository/entity/session.dart';

class LoadingAction {}

class ErrorAction {}

class SessionsLoadAction {}

class SessionsLoadedAction {
  final List<Session> sessions;

  SessionsLoadedAction(this.sessions);
}

class SessionDetailAction {
  final Session session;

  SessionDetailAction(this.session);
}

class SelectBottomNavigationViewAction {
  final int index;

  SelectBottomNavigationViewAction(this.index);
}

class UpdateTabAction {
  final AppTab newTab;

  UpdateTabAction(this.newTab);

  @override
  String toString() {
    return 'UpdateTabAction{newTab: $newTab}';
  }
}

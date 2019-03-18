/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'package:app/theme.dart';
import 'package:architecture/app_tab.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final AppTab currentTab;
  final ValueChanged<AppTab> onTabTap;

  const MenuPage({Key key, this.currentTab, this.onTabTap})
      : assert(currentTab != null),
        assert(onTabTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<AppTab> _tabs = [AppTab.sessions, AppTab.about, AppTab.map, AppTab.enquete];

    return Container(
      alignment: Alignment.center,
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(8.0),
      child: ListView(
        children:
            _tabs.map((AppTab tab) => _buildMenuItem(tab, context)).toList(),
      ),
    );
  }

  Widget _buildMenuItem(AppTab tab, BuildContext context) {
    final menuString = tab.toString().replaceAll('AppTab.', '').toUpperCase();
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      child: tab == currentTab
        ? Container(
        width: 328.0,
        height: 48.0,
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Material(
          color: Color.fromRGBO(255, 255, 255, 0.1),
          child: InkWell(
            highlightColor: Color.fromRGBO(255, 255, 255, 0.1),
            splashColor: Color.fromRGBO(255, 255, 255, 0.1),
            onTap: () => onTabTap(tab),
            child: Center(
              child: Text(
                menuString,
                style: theme.textTheme.body1.copyWith(
                  color: kPrimaryTextColor,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ) : Container(
        width: 328.0,
        height: 48.0,
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Material(
          color: Color.fromRGBO(255, 255, 255, 0.1),
          child: InkWell(
            highlightColor: Color.fromRGBO(255, 255, 255, 0.1),
            splashColor: Color.fromRGBO(255, 255, 255, 0.1),
            onTap: () => onTabTap(tab),
            child: Center(
              child: Text(
                menuString,
                style: theme.textTheme.body2.copyWith(
                  color: kPrimaryTextColor.withAlpha(0x66),
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

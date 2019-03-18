/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:architecture/app_tab.dart';
import 'package:architecture/state.dart';
import 'package:redux/redux.dart';

class ActiveTab extends StatelessWidget {
  final ViewModelBuilder<AppTab> builder;

  ActiveTab({Key key, @required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppTab>(
      distinct: true,
      converter: (Store<AppState> store) => store.state.activeTab,
      builder: builder,
    );
  }
}

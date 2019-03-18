/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'package:app/theme.dart';
import 'package:flutter/material.dart';

class FrontLayerTitle extends StatelessWidget {
  final String title;

  FrontLayerTitle({Key key, @required this.title})
      : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.subhead,
      ),
    );
  }
}

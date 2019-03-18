/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return Center(
      child: isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator()
    );
  }
}

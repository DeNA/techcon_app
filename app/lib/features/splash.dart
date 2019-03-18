/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'package:app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Flare Animation Name
    String _animationName = "Logo";
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          _checkSkipAnimation(context);
        },
        child: Center(
          child: FlareActor(
            "assets/animations/Logo.flr",
            animation: _animationName,
            fit: BoxFit.contain,
            callback: (string) {
              debugPrint("FlareCompleted:$string");
              Navigator.of(context).pushReplacementNamed(AppRoutes.home);
              _setPrefs(true);
            },
          ),
        ),
      ),
    );
  }

  Future<bool> _checkSkipAnimation(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool canSkipAnimation = prefs.getBool('can_skip_animation');
    if (canSkipAnimation == null) {
      canSkipAnimation = false;
    }
    if (canSkipAnimation) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    }
  }

  _setPrefs(bool canSkipAnimation) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('can_skip_animation', canSkipAnimation);
  }
}

/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'package:app/localizations.dart';
import 'package:app/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EnquetePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 40.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  AppLocalizations.of(context).text("enquete"),
                  style: Theme.of(context)
                      .textTheme
                      .subhead,
                  textAlign: TextAlign.left,
                ),
                alignment: Alignment(-1.0, 0),
              ),
              SizedBox(height: 40),
              Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.fill,
                width: 267.0,
                height: 58.0,
              ),
              SizedBox(height: 16),
              Text(
                AppLocalizations.of(context).text("message_enquete_title"),
                style: Theme.of(context)
                    .textTheme
                    .body2
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Text(
                AppLocalizations.of(context).text("message_enquete_detail"),
              ),
              SizedBox(height: 40),
              messageButton(context),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: kSecondaryBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/img_energy_drink.png",
                      fit: BoxFit.fill,
                      width: 26.0,
                      height: 64.0,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      AppLocalizations.of(context).text("message_enquete_drink_1"),
                      style: Theme.of(context)
                          .textTheme
                          .body2
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          color: kTextMainColor,
                        ),
                        SizedBox(width: 12.0),
                        Text(
                          AppLocalizations.of(context).text("message_enquete_drink_2"),
                          style: Theme.of(context)
                              .textTheme
                              .body2
                              .copyWith(fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      AppLocalizations.of(context).text("message_enquete_drink_3"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget messageButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 6.0),
      child: OutlineButton(
        borderSide: BorderSide(color: kPrimaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        child: Text(
          AppLocalizations.of(context).text("enquete_button"),
          style: Theme.of(context)
              .textTheme
              .button
              .copyWith(color: Theme.of(context).accentColor),
        ),
        onPressed: _launchUrl,
      ),
    );
  }

  _launchUrl() async {
    const url = 'https://questant.jp/q/5HKXUV46';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'dart:io';

import 'package:app/features/ui/LinkTextSpan.dart';
import 'package:app/localizations.dart';
import 'package:app/routes.dart';
import 'package:app/theme.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:package_info/package_info.dart';

String urlAccess = 'http://www.hikarie.jp/sp/access/index.html';
String urlMapAndroid =
    'https://www.google.com/maps/search/?api=1&query=35.6590899,139.7015084&query_place_id=ChIJ3e_XUFiLGGARHkJBvl2wVDs';
String urlMapIOS =
    'http://maps.apple.com/?sll=35.6590899,139.7015084&q=%E3%83%92%E3%82%AB%E3%83%AA%E3%82%A8%E3%83%9B%E3%83%BC%E3%83%AB';
String urlTwitter = 'https://twitter.com/DeNAxTech/';
String urlTag = 'https://twitter.com/search?q=%23denatechcon';
String urlTermsMaps = "https://maps.google.com/help/terms_maps.html";
String urlLegalnoticesMaps = "http://maps.google.com/help/legalnotices_maps.html";

class AboutPage extends StatelessWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  const AboutPage({Key key, this.analytics, this.observer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            buildMessage(context),
            SizedBox(height: 16.0),
            buildTwitter(context),
            SizedBox(height: 40.0),
            buildAccess(context),
            SizedBox(height: 16.0),
            buildCodeOfConduct(context),
            SizedBox(height: 16.0),
            buildLicenses(context),
            SizedBox(height: 24.0),
//            buildRightsAttributionMaps(context),
//            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  Widget buildMessage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).text("message"),
          style: Theme.of(context).textTheme.subhead,
        ),
        SizedBox(height: 26.0),
        Image.asset("assets/images/message.png"),
        SizedBox(height: 26.0),
        Text(
          AppLocalizations.of(context).text("message_description"),
        ),
        SizedBox(height: 26.0),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 3.0),
          child: Image.asset("assets/images/logo_shift_up.png"),
        ),
        SizedBox(height: 26.0),
        Row(
          children: <Widget>[
            Text(
              AppLocalizations.of(context).text("message_theme_1"),
            ),
            Text(
              AppLocalizations.of(context).text("message_theme_2"),
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              AppLocalizations.of(context).text("message_theme_3"),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          AppLocalizations.of(context).text("message_last"),
        ),
      ],
    );
  }

  Widget buildTwitter(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kSecondaryBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Text(
                  AppLocalizations.of(context).text("twitter_label"),
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(fontSize: 14.0),
                ),
              ),
              Expanded(
                flex: 6,
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      LinkTextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Theme.of(context).accentColor),
                        url: urlTwitter,
                        text: "@DeNAxTech",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Text(
                  AppLocalizations.of(context).text("twitter_tag_label"),
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(fontSize: 14.0),
                ),
              ),
              Expanded(
                flex: 6,
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      LinkTextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Theme.of(context).accentColor),
                        url: urlTag,
                        text: "#denatechcon",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAccess(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).text("access"),
          style: Theme.of(context).textTheme.subhead,
        ),
        SizedBox(height: 24.0),
        buildGoogleMap(context),
        Text(AppLocalizations.of(context).text("building"),
            style: Theme.of(context).textTheme.title.copyWith(fontSize: 18.0)),
        SizedBox(height: 8.0),
        Text(
          AppLocalizations.of(context).text("address"),
          style:
              Theme.of(context).textTheme.body1.copyWith(color: kTextSubColor),
        ),
        SizedBox(height: 16.0),
        RichText(
          text: LinkTextSpan(
            style: Theme.of(context).textTheme.body1.copyWith(
                color: Theme.of(context).accentColor),
            url: Platform.isIOS ? urlMapIOS : urlMapAndroid,
            text: AppLocalizations.of(context).text("open_map"),
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "●",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: kPrimaryColor),
            ),
            SizedBox(width: 8.0),
            Expanded(
                child: Text(
              AppLocalizations.of(context).text("public_transportation_1"),
              style: Theme.of(context).textTheme.body1,
            )),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "●",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: kPrimaryColor),
            ),
            SizedBox(width: 8.0),
            Expanded(
                child: Text(
              AppLocalizations.of(context).text("public_transportation_2"),
              style: Theme.of(context).textTheme.body1,
            )),
          ],
        ),
        SizedBox(height: 8.0),
//        FlatButton(
//          child: Text(
//            AppLocalizations.of(context).text("access_map"),
//            style: Theme.of(context).textTheme.button.copyWith(
//                color: Theme.of(context).accentColor,
//                decoration: TextDecoration.underline),
//          ),
//          onPressed: () async {
//            var urlMap = Platform.isIOS ? urlMapIOS : urlMapAndroid;
//            if (await canLaunch(urlAccess)) {
//              launch(urlMap, forceSafariVC: false);
//            } else {
//              debugPrint('Could not launch $urlMap');
//            }
//          },
//        ),
      ],
    );
  }

  Widget buildGoogleMap(BuildContext context) {
    return Platform.isIOS
        ? Container()
        : Container(
            padding: EdgeInsets.only(bottom: 16.0),
            child: SizedBox(
              height: 300.0,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(35.659025, 139.703473),
                  zoom: 16.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  var options = MarkerOptions(
                    position: LatLng(35.659025, 139.703473),
                  );
                  controller.addMarker(options);
                },
              ),
            ),
          );
  }

  Widget buildCodeOfConduct(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 6.0),
      child: OutlineButton(
        borderSide: BorderSide(color: kPrimaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        child: Text(
          AppLocalizations.of(context).text("code_of_conduct"),
          style: Theme.of(context)
              .textTheme
              .button
              .copyWith(color: Theme.of(context).accentColor),
        ),
        onPressed: () => Navigator.pushNamed(context, AppRoutes.codeOfConduct),
      ),
    );
  }

  Widget buildLicenses(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 6.0),
      child: OutlineButton(
        borderSide: BorderSide(color: kPrimaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        child: Text(
          AppLocalizations.of(context).text("licenses"),
          style: Theme.of(context)
              .textTheme
              .button
              .copyWith(color: Theme.of(context).accentColor),
        ),
//        onPressed: () => showLicensePage(context: context),
        onPressed: () {
          PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
            showLicensePage(
              context: context,
              applicationName: packageInfo.appName,
              applicationIcon: Image.asset("assets/images/App_Icon.png"),
              applicationVersion: packageInfo.version,
            );
          });
        },
      ),
    );
  }

  Widget buildRightsAttributionMaps(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(AppLocalizations.of(context).text("rights_attribution_maps"),
            style: Theme.of(context).textTheme.caption),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: LinkTextSpan(
                style: Theme.of(context).textTheme.body1.copyWith(
                    color: Theme.of(context).accentColor),
                url: urlTermsMaps,
                text: AppLocalizations.of(context).text("terms_maps"),
              ),
            ),
            SizedBox(width: 8.0),
            RichText(
              text: LinkTextSpan(
                style: Theme.of(context).textTheme.body1.copyWith(
                    color: Theme.of(context).accentColor),
                url: urlLegalnoticesMaps,
                text: AppLocalizations.of(context).text("legalnotices_maps"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'package:app/features/ui/LinkTextSpan.dart';
import 'package:app/localizations.dart';
import 'package:app/theme.dart';
import 'package:flutter/material.dart';

String urlCoC =
    "https://docs.google.com/document/d/16VhNCZBWWwjQQXkSXfg6evR1frdHHbHb7g-m80xSrgA/edit";
String urlCC = "https://creativecommons.org/publicdomain/zero/1.0/";

class CodeOfConductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(AppLocalizations.of(context).text("code_of_conduct")),
      ),
      backgroundColor: kPrimaryColor,
      body: Container(
        decoration: BoxDecoration(
          color: kPrimaryBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        ),
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 8.0),
            Text(
              AppLocalizations.of(context).text("code_of_conduct_description"),
            ),
            SizedBox(height: 8.0),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    style: Theme.of(context).textTheme.body1,
                    text: AppLocalizations.of(context)
                        .text("code_of_conduct_appendix_1_1"),
                  ),
                  LinkTextSpan(
                    style: Theme.of(context).textTheme.body1.copyWith(
                        color: Theme.of(context).accentColor,
                        decoration: TextDecoration.underline),
                    url: urlCoC,
                    text: AppLocalizations.of(context)
                        .text("code_of_conduct_appendix_1_2"),
                  ),
                  TextSpan(
                    style: Theme.of(context).textTheme.body1,
                    text: AppLocalizations.of(context)
                        .text("code_of_conduct_appendix_1_3"),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    style: Theme.of(context).textTheme.body1,
                    text: AppLocalizations.of(context)
                        .text("code_of_conduct_appendix_2_1"),
                  ),
                  LinkTextSpan(
                    style: Theme.of(context).textTheme.body1.copyWith(
                        color: Theme.of(context).accentColor,
                        decoration: TextDecoration.underline),
                    url: urlCC,
                    text: AppLocalizations.of(context)
                        .text("code_of_conduct_appendix_2_2"),
                  ),
                  TextSpan(
                    style: Theme.of(context).textTheme.body1,
                    text: AppLocalizations.of(context)
                        .text("code_of_conduct_appendix_2_3"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

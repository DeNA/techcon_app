/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'package:app/features/widget/loading_indicator.dart';
import 'package:app/localizations.dart';
import 'package:app/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:flutter_advanced_networkimage/transition_to_image.dart';
import 'package:repository/entity/business.dart';
import 'package:repository/entity/person.dart';
import 'package:repository/entity/session.dart';
import 'package:repository/entity/sns.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/features/ui/LinkTextSpan.dart';

class SessionPage extends StatelessWidget {
  final Session session;

  const SessionPage({Key key, this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("$session");

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(AppLocalizations.of(context).text("session_detail")),
      ),
      backgroundColor: kPrimaryColor,
      body: Container(
        decoration: BoxDecoration(
          color: kPrimaryBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        ),
        child: Container(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: List<Widget>()
              ..add(Text(
                AppLocalizations.of(context).text("title"),
                style: Theme.of(context).textTheme.subhead,
              ))
              ..add(SizedBox(height: 8.0))
              ..addAll(buildTitle(context, session.business))
              ..add(SizedBox(height: 40.0))
              ..add(Text(
                AppLocalizations.of(context).text("speaker"),
                style: Theme.of(context).textTheme.subhead,
              ))
              ..add(SizedBox(height: 16.0))
              ..addAll(buildPersons(context, session.persons)),
          ),
        ),
      ),
    );
  }

  List<Widget> buildTitle(BuildContext context, Business business) {
    String stageSchedule = "${business.stage} ${business.startAt} - ${business.endAt}";
    return [
      Text(
        business.title,
        style: Theme.of(context).textTheme.title,
      ),
      SizedBox(height: 24.0),
      Text(stageSchedule),
      SizedBox(height: 16.0),
      business.category == null
          ? Container()
          : Container(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              decoration: BoxDecoration(
                color: kSecondaryBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        height: 36.0,
                        width: 36.0,
                        child: TransitionToImage(
                          image: AdvancedNetworkImage(
                            business.category.icon,
                            loadFailedCallback: () {
                              debugPrint('Could not get ${business.category.icon}');
                            },
                          ),
                          fit: BoxFit.scaleDown,
                          loadingWidget: LoadingIndicator(),
                          placeholder: Icon(
                            Icons.category,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(business.category.text),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: (business.services != null) ? business.services.length : 0,
                    itemBuilder: (context, int index) {
                      return Container(
                        margin: EdgeInsets.only(top: 8.0),
                        child: RichText(
                          text: LinkTextSpan(
                            style: Theme.of(context).textTheme.body1.copyWith(
                              color: Theme.of(context).accentColor,
                              fontSize: 16.0,
                            ),
                            url: business.services[index].url,
                            text: business.services[index].name,
                          ),
                        ),
                      );
                    },
                  ),
                ]
              ),
            ),
      SizedBox(height: 31.0),
      Text(
        business.text,
        style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16.0),
      ),
      SizedBox(height: 16.0),
      Wrap(
          spacing: 8.0,
          children: business.tags
              .map((tag) => Text(
                    tag,
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: kTextSubColor),
                  ))
              .toList())
    ];
  }

  List<Widget> buildPersons(BuildContext context, List<Person> persons) {
    return session.persons
        .map((person) => buildPerson(context, person))
        .toList();
  }

  Widget buildPerson(BuildContext context, Person person) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                child: Strings.isNullOrEmpty(person.imageUrl)
                    ? FittedBox(
                        child: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        fit: BoxFit.fill,
                      )
                    : TransitionToImage(
                        image: AdvancedNetworkImage(
                          person.imageUrl,
                          loadFailedCallback: () {
                            debugPrint('Could not get ${person.imageUrl}');
                          },
                        ),
                        fit: BoxFit.contain,
                        loadingWidget: LoadingIndicator(),
                        placeholder: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                      ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 6.0),
                        child: Text(
                          person.name,
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      buildSns(person.sns),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Container(
            decoration: BoxDecoration(
              color: kSecondaryBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            padding: EdgeInsets.all(8.0),
            child: Text(person.profile),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget buildSns(List<Sns> snses) {
    if (snses == null) return Container();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: snses
          .map(
            (sns) => SizedBox(
                  child: IconButton(
                    icon: TransitionToImage(
                      image: AdvancedNetworkImage(
                        sns.icon,
                        loadFailedCallback: () {
                          debugPrint('Could not get ${sns.icon}');
                        },
                      ),
                      fit: BoxFit.contain,
                      loadingWidget: LoadingIndicator(),
                      placeholder: Icon(Icons.link),
                    ),
                    onPressed: () async {
                      if (await canLaunch(sns.url)) {
                        launch(sns.url, forceSafariVC: false);
                      } else {
                        debugPrint('Could not launch $sns.url');
                      }
                    },
                  ),
                ),
          )
          .toList(),
    );
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

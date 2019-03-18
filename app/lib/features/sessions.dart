/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'package:app/features/session.dart';
import 'package:app/features/widget/front_layer_title.dart';
import 'package:app/features/widget/loading_indicator.dart';
import 'package:app/localizations.dart';
import 'package:app/theme.dart';
import 'package:collection/collection.dart';
import 'package:commons/commons.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:architecture/actions.dart';
import 'package:architecture/state.dart';
import 'package:redux/redux.dart';
import 'package:repository/entity/session.dart';

class SessionsPage extends StatelessWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  SessionsPage({Key key, this.analytics, this.observer}) : super(key: key);

  // TODO: analytics and observer
  // plugins/packages/firebase_analytics/example/lib at master · flutter/plugins https://github.com/flutter/plugins/tree/master/packages/firebase_analytics/example/lib

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: <Widget>[
          FrontLayerTitle(title: "SCHEDULE"),
          Expanded(
            child: TimeTablePage(),
          ),
        ],
      )),
    );
  }
}

class TimeTablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInit: (store) => store.dispatch(SessionsLoadAction()),
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        if (vm.isLoading) {
          return Center(child: LoadingIndicator());
        } else {
          return TimeTable(
            sessions: vm.sessions,
            onTap: (Session session) {
              // TODO: to Action Dispatch ?
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        SessionPage(session: session),
                  ));
            },
          );
        }
      },
    );
  }
}

class _ViewModel {
  final List<Session> sessions;
  final bool isLoading;

  _ViewModel({
    this.sessions,
    this.isLoading,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      sessions: store.state.sessions,
      isLoading: store.state.isLoading,
    );
  }
}

class TimeTable extends StatelessWidget {
  final List<Session> sessions;
  final Function(Session session) onTap;

  const TimeTable({Key key, this.sessions, this.onTap}) : super(key: key);

  /// セッションからタイムテーブルを抜き出し
  List<Pair<String, String>> _createSessionTimetable(
      List<Session> sessions, String stage) {
    return sessions
        .where((session) => session.business.stage
            .toLowerCase()
            .startsWith(stage.toLowerCase()))
        .map(
            (session) => Pair(session.business.startAt, session.business.endAt))
        .toList()
          ..sort((a, b) => a.first.compareTo(b.first));
  }

  /// ステージ毎のセッションを抜き出し
  Map<Pair<String, String>, Session> _extractSessionsByStage(
      List<Session> sessions, String stage) {
    final Map<Pair<String, String>, Session> map = {};
    sessions
        .where((session) => session.business.stage
            .toLowerCase()
            .startsWith(stage.toLowerCase()))
        .toList()
        .forEach((session) {
      map[Pair(session.business.startAt, session.business.endAt)] = session;
    });
    return map;
  }

  @override
  Widget build(BuildContext context) {
    // Define Widget's sizes
    final Size size = MediaQuery.of(context).size;
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
// TODO:
//    How can Flutter handle dpi text and image size differences - Stack Overflow https://stackoverflow.com/questions/44173641/how-can-flutter-handle-dpi-text-and-image-size-differences

    debugPrint('Size:$size, devicePixelRatio:$devicePixelRatio');

    final double sideHeaderWidth = 56.0;
    final double cellWidth = size.width * (200 / 360);
    final double rowWidth = cellWidth * 4;

// FIXME: A RenderFlex overflowed by 28 pixels on the bottom. Tag overflow...
//    final double sellHeight = size.height / 2.5;
//    final double sellHeight = size.height / 4.0;
//    final double cellHeight = 270.0;
    final double cellHeight = 170.0;

// iPhone XR  : Size:Size(414.0, 896.0), devicePixelRatio:2.0
// Pixel 2    : Size:Size(411.4, 683.4), devicePixelRatio:2.625
// Nexus 5    : Size:Size(360.0, 592.0), devicePixelRatio:3.0
// ZenPhone 3 : Size:Size(360.0, 640.0), devicePixelRatio:3.0
// Nexus 6P   : Size:Size(411.4, 683.4), devicePixelRatio:3.5

    // Scroll View
    final ScrollController scheduleController = ScrollController();
    final ScrollController sideHeaderController = ScrollController();
    scheduleController.addListener(() {
      // コンテンツとサイドヘッダーのタイムリストを同期
      sideHeaderController.jumpTo(scheduleController.offset);
    });

    // Decoration for Cell
    final double borderWidth = 0.4;
    final Border border = Border.all(width: borderWidth, color: kTimetableBorderColor);
    final BoxDecoration boxDecoration = BoxDecoration(border: border);
    final BoxDecoration boxDecorationBottomNone = BoxDecoration(
      border: Border(
        top: BorderSide(width: borderWidth, color: kTimetableBorderColor),
        right: BorderSide(width: borderWidth, color: kTimetableBorderColor),
        left: BorderSide(width: borderWidth, color: kTimetableBorderColor),
      ),
    );
    final BoxDecoration boxDecorationTopNone = BoxDecoration(
      border: Border(
        right: BorderSide(width: borderWidth, color: kTimetableBorderColor),
        bottom: BorderSide(width: borderWidth, color: kTimetableBorderColor),
        left: BorderSide(width: borderWidth, color: kTimetableBorderColor),
      ),
    );

    // Stage 毎のセッション一覧
    List<String> stages = [
      AppLocalizations.of(context).text("stage_a"),
      AppLocalizations.of(context).text("stage_b"),
      AppLocalizations.of(context).text("stage_c"),
      AppLocalizations.of(context).text("stage_d"),
    ];
    List<Map<Pair<String, String>, Session>> sessionsByStage = [
      _extractSessionsByStage(sessions, stages.elementAt(0)),
      _extractSessionsByStage(sessions, stages.elementAt(1)),
      _extractSessionsByStage(sessions, stages.elementAt(2)),
      _extractSessionsByStage(sessions, stages.elementAt(3)),
    ];

    // A Stage を基準にセッションのタイムテーブルを作成
    List<Pair<String, String>> sessionTimetable =
        _createSessionTimetable(sessions, stages.elementAt(0));
    // A Stage を基準にセッション数を決定
    int sessionCount = sessionTimetable.length;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Schedule
          Container(
            padding: EdgeInsets.only(left: sideHeaderWidth),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: rowWidth,
                child: CustomScrollView(
                  controller: scheduleController,
                  slivers: <Widget>[
                    // --------------------------------------------------------
                    // Schedule Header
                    // --------------------------------------------------------
                    SliverAppBar(
                      elevation: 0.0,
                      pinned: true,
                      backgroundColor: kTimetableHeaderBackgroundColor,
                      flexibleSpace: ListView.builder(
                        itemBuilder: (BuildContext context, int j) {
                          return Container(
                            decoration: boxDecoration,
                            width: cellWidth,
                            height: 40.0,
                            alignment: Alignment.center,
                            child: Text(
                              stages.elementAt(j),
                              style: Theme.of(context)
                                  .textTheme
                                  .body1
                                  .apply(color: kPrimaryColor),
                            ),
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                      ),
                    ),
                    // --------------------------------------------------------
                    // Schedule Items
                    // --------------------------------------------------------
                    SliverFixedExtentList(
                      itemExtent: cellHeight,
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int i) {
                          return Container(
                            alignment: Alignment.center,
                            child: ListView.builder(
                              itemBuilder: (BuildContext context, int j) {
//                                debugPrint(
//                                    "${stages.elementAt(j)} : ${sessionTimetable.elementAt(i)}");
//                                debugPrint("---------");
//                                debugPrint("${sessionsByStage.elementAt(j)}");
//                                debugPrint("---------");
                                // セッションの表示
                                if (j < sessionsByStage.length) {
                                  // ステージのセッションを取得
                                  Map<Pair<String, String>, Session> sessions =
                                      sessionsByStage.elementAt(j);
                                  // タイムテーブルに該当するステージのセッションを取得
                                  Session session =
                                      sessions[sessionTimetable.elementAt(i)];
                                  // セッションが存在した場合、内容を描画する
                                  if (session != null) {
                                    var sb = StringBuffer();
                                    sb.writeAll(session.business.tags, " ");
                                    var tags = sb.toString();

                                    var decoration = boxDecoration;
                                    return InkWell(
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        decoration: decoration,
                                        width: cellWidth,
                                        height: cellHeight,
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "${session.business.title}",
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .body2,
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            Text(
                                              tags,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        onTap(session);
                                      },
//                                      onTap: () => onTap(session),
                                    );
                                  }
                                }
                                return Container(
                                  decoration: boxDecoration,
                                  width: cellWidth,
                                  padding: EdgeInsets.all(8.0),
                                );
                              },
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                            ),
                          );
                        },
                        childCount: sessionCount,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // ------------------------------------------------------------------
          // Side Timeline Header
          // ------------------------------------------------------------------
          Container(
            child: SizedBox(
              width: sideHeaderWidth,
              child: CustomScrollView(
                controller: sideHeaderController,
                physics: NeverScrollableScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    elevation: 0.0,
                    pinned: true,
                    backgroundColor: kTimetableHeaderBackgroundColor,
                    flexibleSpace: Container(
                      decoration: boxDecoration,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  SliverFixedExtentList(
                    itemExtent: cellHeight,
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int i) {
                        Pair<String, String> time =
                            sessionTimetable.elementAt(i);
                        return Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: border,
                            color: kTimetableHeaderBackgroundColor,
                          ),
                          child: Text(
                            "${time.first}\n - \n${time.second}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .apply(color: kPrimaryColor),
                          ),
                        );
                      },
                      childCount: sessionCount,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

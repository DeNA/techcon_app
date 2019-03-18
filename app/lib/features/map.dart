/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'package:app/features/widget/loading_indicator.dart';
import 'package:app/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:flutter_advanced_networkimage/transition_to_image.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).text("floor_map"),
              style: Theme.of(context).textTheme.subhead,
            ),
            SizedBox(height: 26.0),
// TIPS: When Airplane mode, raise FlutterException: SocketException: Failed host lookup: 'com-dena-techcon.firebaseapp.com' (OS Error: No address associated with hostname, errno = 7)
//        child: Image.network("https://com-dena-techcon.firebaseapp.com/image/stage_map.png")
// TIPS: When Airplane mode, raise FlutterException "Couldn't download or retreive file.". errorWidget does not work ... !?
//        child: CachedNetworkImage(
//          imageUrl: "https://com-dena-techcon.firebaseapp.com/image/stage_map.png",
//          placeholder: LoadingIndicator(),
//          fit: BoxFit.cover,
//          errorWidget: Icon(Icons.broken_image, color: Colors.grey, size: 48.0),
//        ),
            TransitionToImage(
              image: AdvancedNetworkImage(
                'https://com-dena-techcon.firebaseapp.com/image/stage_map.png',
                loadFailedCallback: () {
                  debugPrint('Could not get map image');
                },
              ),
              fit: BoxFit.fitWidth,
              loadingWidget: LoadingIndicator(),
              placeholder: Icon(
                Icons.broken_image,
                color: Colors.grey,
                size: 48.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

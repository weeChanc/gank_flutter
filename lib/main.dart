import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:gank_flutter/ui/main/main.dart';
import 'package:gank_flutter/ui/photo/photo_list.dart';
import 'package:gank_flutter/ui/setting/setting.dart';
import 'package:gank_flutter/ui/tzcs/tzcs.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AppState();
  }
}

class _AppState extends State<MyApp> {
  @override
  void initState() {
    FlutterBoost.singleton.registerPageBuilders({
      ///可以在native层通过 getContainerParams 来传递参数
      'flutter_main': (pageName, params, _) {
        print("flutterPage params:$params");
        return MainPage();
      },
    });

    ///query current top page and load it
    FlutterBoost.handleOnStartPage();
  }

  Map<String, WidgetBuilder> routes = {
    "second": (BuildContext context) =>
        MainPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: FlutterBoost.init(postPush: _onRoutePushed),
      routes: routes,
      home: Container(),
    );
  }

  void _onRoutePushed(
      String pageName, String uniqueId, Map params, Route route, Future _) {
//    List<OverlayEntry> newEntries = route.overlayEntries
//        .map((OverlayEntry entry) => OverlayEntry(
//            builder: (BuildContext context) {
//              final pageWidget = entry.builder(context);
//              return Stack(
//                children: <Widget>[
//                  pageWidget,
//                  Positioned(
//                    child: Text(
//                      "pageName:$pageName\npageWidget:${pageWidget.toStringShort()}",
//                      style: TextStyle(fontSize: 12.0, color: Colors.red),
//                    ),
//                    left: 8.0,
//                    top: 8.0,
//                  )
//                ],
//              );
//            },
//            opaque: entry.opaque,
//            maintainState: entry.maintainState))
//        .toList(growable: true);
//
//    route.overlayEntries.clear();
//    route.overlayEntries.addAll(newEntries);
  }
}

import 'package:flutter/material.dart';
import 'package:gank_flutter/base/logger/logger.dart';
import 'package:gank_flutter/base/status.dart';
import 'package:gank_flutter/ui/home/tabpage.dart';
import 'package:gank_flutter/ui/home/type.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State {

  final tabTypes = [
    TabType.RECOMMEND,
    TabType.FONT_END,
    TabType.ANDROID,
    TabType.IOS,
    TabType.BACK_END,
    TabType.PRETTY,
  ];

  var currentTabStatus = Status(TabType.RECOMMEND);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: tabTypes.length,
      child: Container(
        child: Column(
          children: <Widget>[
            TabBar(
                isScrollable: true,
                onTap: (pos) => setState(() {
                      currentTabStatus.val = tabTypes[pos];
                    }),
                labelColor: Colors.blue,
                tabs: tabTypes.map((type) => Tab(text: type.name)).toList()),
            HomeTabPage(currentTabStatus),
          ],
        ),
      ),
    ));
  }
}

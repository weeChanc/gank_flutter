import 'package:flutter/material.dart';
import 'package:gank_flutter/base/status.dart';
import 'package:gank_flutter/ui/home/model/type.dart';
import 'package:gank_flutter/ui/home/tab_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State {
  final tabTypes = [
    TabType.TODAY,
    TabType.FONT_END,
    TabType.ANDROID,
    TabType.IOS,
//    TabType.BACK_END,
    TabType.PRETTY,
  ];

  var currentTabStatus = Status(TabType.TODAY);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabTypes.length,
      child: Scaffold(
          appBar: TabBar(
              onTap: (pos) => setState(() {
                    currentTabStatus.val = tabTypes[pos];
                  }),
              labelColor: Colors.blue,
              tabs: tabTypes.map((type) => Tab(text: type.name)).toList()),
          body: TabBarView(
              children: tabTypes.map((type) => HomeTabPage(type)).toList())),
    );
  }
}

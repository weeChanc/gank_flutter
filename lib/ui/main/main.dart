import 'package:flutter/material.dart';
import 'package:gank_flutter/ui/history/history.dart';
import 'package:gank_flutter/ui/home/home.dart';
import 'package:gank_flutter/ui/photo/photo_list.dart';
import 'package:gank_flutter/ui/setting/setting.dart';
import 'package:flutter_boost/flutter_boost.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);
  final String title = "good";

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _currentPage = 0;
  var _pages = <Widget>[HomePage(), HistoryPage(), SettingPage()];

  _MainPageState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _pages[_currentPage],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  buildBottomNavigationBar() {
    const _bottomNavigationColor = Colors.blue;
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _bottomNavigationColor,
            ),
            title: Text(
              '首页',
              style: TextStyle(color: _bottomNavigationColor),
            )),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              color: _bottomNavigationColor,
            ),
            title: Text(
              '历史',
              style: TextStyle(color: _bottomNavigationColor),
            )),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: _bottomNavigationColor,
            ),
            title: Text(
              '设置',
              style: TextStyle(color: _bottomNavigationColor),
            )),
      ],
      onTap: (pos) {
        if (pos == 1) {
          FlutterBoost.singleton.openPage("native://main", null);
        }

        if (pos == 2) {
          Navigator.pushNamed(context, "/setting");
        }

      },
    );
  }
}

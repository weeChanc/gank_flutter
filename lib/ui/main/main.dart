import 'package:flutter/material.dart';
import 'package:gank_flutter/ui/home/home.dart';
import 'package:gank_flutter/ui/photo/photo_list.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _bottomBar;
  var _currentPage = 0;
  var _pages = <Widget>[HomePage(), PhotoListView(), PhotoListView()];

  _MainPageState() {
    _bottomBar = buildBottomNavigationBar();
  }

  void _incrementCounter() {
    Navigator.pushNamed(context, "/photolist");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _pages[_currentPage],
      floatingActionButton: buildFab(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  buildFab() {
    return FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: 'Increment',
      child: Icon(Icons.add),
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
        setState(() {
          {
            _currentPage = pos;
          }
        });
      },
    );
  }
}

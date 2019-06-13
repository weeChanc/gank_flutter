import 'package:flutter/material.dart';
import 'package:gank_flutter/ui/home/home.dart';
import 'package:gank_flutter/ui/photo/photo_list.dart';
import 'package:gank_flutter/ui/setting/setting.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    print("create state");
    return MyState();
  }
}

class MyState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    print("good");
    ;
    print(context.hashCode);
    return Container();
  }
}

class _MainPageState extends State<MainPage> {
  var _currentPage = 0;
  var _pages = <Widget>[HomePage(), PhotoListView(), SettingPage()];

  _MainPageState();

  FocusNode node1 = new FocusNode();
  FocusNode node2 = new FocusNode();
  GlobalKey key1 = new GlobalKey();
  GlobalKey key2 = new GlobalKey();
  GlobalKey activeKey;
  FocusNode activeNode;

  @override
  void initState() {
    node1 = new FocusNode();
    node2 = new FocusNode();
    node1.addListener(() {
      if (node1.hasFocus) {
        activeKey = key1;
        activeNode = node1;
      }
    });

    node2.addListener(() {
      if (node2.hasFocus) {
        activeKey = key2;
        activeNode = node2;
      }
    });
  }

  void _incrementCounter() {
    setState(() {
      _currentPage++;
    });
  }

  @override
  void dispose() {
    node1.dispose();
    node2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = new TextEditingController();
    var children = <Widget>[];
    if (_currentPage % 2 == 0) {
      children.add(TextField(
        autofocus: true,
        focusNode: node1,
      ));
      children.add(
        TextField(
          focusNode: node2,
        ),
      );
    } else {
      children.add(Text("good"));
      children.add(TextField(
        autofocus: true,
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: MyWidget(),
      ),
      body: Column(
        children: children,
      ),
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
        if (pos == 2) {
          Navigator.pushNamed(context, "/setting");
        } else if (pos == 1) {
          Navigator.pushNamed(context, "/tzcs");
        } else {
          setState(() {
            {
              _currentPage = pos;
            }
          });
        }
      },
    );
  }
}

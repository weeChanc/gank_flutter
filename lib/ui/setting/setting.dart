import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SettingState();
  }
}

class _Item {
  final String title;

  final IconData iconLeft;
  final IconData iconRight;

  const _Item(this.title, this.iconLeft,
      [this.iconRight = Icons.arrow_forward_ios]);
}

class _SettingState extends State {
  final _list = [
    _Item("检查更新", Icons.file_download),
    _Item("关于作者", Icons.settings),
    _Item("体测查询", Icons.search),
    _Item("退出", Icons.transit_enterexit),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: ListView.builder(
              itemCount: _list.length,
              itemBuilder: (ctx, pos) => ListTile(
                    title: Text(_list[pos].title),
                    leading: Icon(_list[pos].iconLeft),
                    trailing: Icon(_list[pos].iconRight),
                  ))),
    );
  }
}

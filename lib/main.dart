import 'package:flutter/material.dart';
import 'package:gank_flutter/ui/main/main.dart';
import 'package:gank_flutter/ui/photo/photo_list.dart';
import 'package:gank_flutter/ui/setting/setting.dart';
import 'package:gank_flutter/ui/tzcs/tzcs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: 'Flutter Demo Home Page'),
      routes: {
        "/photolist": (ctx) => PhotoListView(),
        "/setting": (ctx) => SettingPage(),
        "/tzcs": (ctx) => SHIT(),
      },
    );
  }
}

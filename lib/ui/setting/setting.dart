import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SettingState();
  }
}

class _SettingState extends State{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text("Setting PAGE")
      ),
    );
  }

}
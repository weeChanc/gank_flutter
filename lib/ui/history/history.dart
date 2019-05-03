import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HistoryState();
  }
}

class _HistoryState extends State{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text("History PAGE")
      ),
    );
  }

}
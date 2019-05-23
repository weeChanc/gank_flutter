  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';

  class SHIT extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
      return _State();
    }
}

class _State extends State<SHIT> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: "GOOD",
      ),
      child: Container(
          margin: EdgeInsets.only(top: 64),
          child: Column(
            children: <Widget>[
              CupertinoTextField(
                placeholder: "学号",
              ),
              CupertinoTextField(
                placeholder: "姓名",
              ),
            ],
          )),
    );
  }
}

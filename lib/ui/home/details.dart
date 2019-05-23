import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailPage extends StatelessWidget {
  Map _data;

  DetailPage(this._data);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: Key(_data["url"]),
      appBar: AppBar(
        title: Text(_data["desc"]),
        leading: Container(
          width: 100,
          height: 100,
          color: Colors.red,
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () => {},
            child: Icon(Icons.exposure_plus_1),
          )
        ],

      ),
      body: WebView(
        initialUrl: _data["url"],
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest  req){
          return NavigationDecision.prevent;
        },
      ),
    );
  }
}

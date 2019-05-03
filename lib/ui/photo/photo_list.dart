import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'photo_model.dart';

class PhotoListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PhotoListState();
  }
}

class PhotoListState extends State<PhotoListView> {
  List<dynamic> data = [];

  @override
  void initState() {
    fetchData();
  }

  void fetchData() async {
    var history = await photoModel.getHistory();
    for (var date in history["result"]) {}

    setState(() {
      data = (history["results"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: getBody(),
    ));
  }

  Widget getBody() {
    if (data.length == 0) {
      return CupertinoActivityIndicator();
    } else {
      return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int position) {
            return getItem(position);
          });
    }
  }

  Widget getItem(pos) {
    return Image.network(data[pos]["url"]);
  }
}

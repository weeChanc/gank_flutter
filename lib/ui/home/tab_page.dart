import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gank_flutter/base/base.dart';
import 'package:gank_flutter/platform/platform.dart';
import 'package:gank_flutter/ui/home/model/tab_model.dart';
import 'package:gank_flutter/ui/home/model/type.dart';
import 'package:gank_flutter/widget/image.dart';

class HomeTabPage extends BaseStatefulWidget {
  TabType _type;

  HomeTabPage(this._type) {}

  @override
  State<StatefulWidget> createState() {
    return _HomeTabPageState(_type);
  }
}

class _HomeTabPageState extends BaseState<HomeTabPage> {
  final model = TabModel();
  final _strategy = Map();

  TabType _type;
  GlobalKey<RefreshIndicatorState> _refreshStateKey = GlobalKey();

  _HomeTabPageState(this._type) {
    _strategy
      ..[TabType.PRETTY] = _createPrettyTab
      ..[TabType.ANDROID] = _createTypeTab
      ..[TabType.TODAY] = _createTypeTab
      ..[TabType.FONT_END] = _createTypeTab
      ..[TabType.IOS] = _createTypeTab;
  }

  @override
  Widget build(BuildContext context) {
    return _strategy[_type]();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 30)).then((_) {
      if (_refreshStateKey.currentState == null) {
        Future.delayed(Duration(microseconds: 30)).then((_) {
          _refreshStateKey.currentState?.show();
          // try again promise loading~ not promise actually lazy~
        });
      } else {
        _refreshStateKey.currentState.show();
      }
    });
  }

  // -emmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm=======================

  Future _onRefresh() async {
    await model.loadTypeData(_type);
    setState(() {});
  }

  // emmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm--=-=-===


  Widget _createPrettyTab() {
    return RefreshIndicator(
        key: _refreshStateKey,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: model.data.length,
          itemBuilder: (ctx, pos) {
            return Container(
                child: Card(
                  child: SuperImage.network(
                      model.data[pos],
                      width: 120,
                      height: 120,
                      key: ValueKey(model.data[pos]),
                  ),
                ));
          },
        ),
        onRefresh: _onRefresh);
  }

  Widget _createTypeTab() {
    return Center(
      child: RefreshIndicator(
        key: _refreshStateKey,
        child: ListView.builder(
            itemCount: model.data.length,
            itemBuilder: (ctx, pos) {
              var data = model.data[pos];
              return createListViewItem(data);
            }),
        onRefresh: _onRefresh,
      ),
    );
  }

  ///emmmmmmmmmmmmmmmmmmmmmmmmm
  Widget createListViewItem(data) =>
      GestureDetector(
        onTap: () => {platform.openWebView(data["url"])},
        child: Card(
          margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              color: Colors.blue,
                              size: 16,
                            ),
                            Text("  ${data["createdAt"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 122, 122, 122),
                                ))
                          ],
                        ),
                      ),
                      Text(
                        "[${data['type']}]",
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Text(data["desc"]),
                ),
                Text("作者:${data["who"]}")
              ],
            ),
          ),
        ),
      );
}

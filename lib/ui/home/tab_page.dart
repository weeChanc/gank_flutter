import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gank_flutter/base/base.dart';
import 'package:gank_flutter/platform/file_provider.dart';
import 'package:gank_flutter/ui/home/model/tab_model.dart';
import 'package:gank_flutter/ui/home/model/type.dart';
import 'package:gank_flutter/widget/image.dart';
import 'package:gank_flutter/widget/image_loader.dart';

import 'details.dart';

class HomeTabPage extends BaseStatefulWidget {
  final TabType _type;

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

  Timer _timer;

  int current = 0;
  PageController controller = new PageController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 30)).then((_) {
      if (_refreshStateKey.currentState == null) {
        Future.delayed(Duration(microseconds: 30)).then((_) {
          if (mounted) {
            _refreshStateKey.currentState?.show();
          }
        });
      } else {
        if (mounted) {
          _refreshStateKey.currentState?.show();
        }
      }
    });

    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) async {
      if (!controller.hasClients) return;
      controller.animateToPage(current,
          duration: Duration(seconds: 1), curve: Curves.fastLinearToSlowEaseIn);

      current = (current + 1) % model.gankMeizi.length ?? 0;
      if (current > model.gankMeizi.length / 1.5) {
        await model.loadMeiziData();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  // -emmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm=======================

  Future _onRefresh() async {
    model.gankMeizi.clear();
    await model.loadTypeData(_type);
    await model.loadMeiziData();
    setState(() {});
  }

  // emmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm--=-=-===

  Widget _createPrettyTab() {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: RefreshIndicator(
          key: _refreshStateKey,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                //纵轴间距
                mainAxisSpacing: 8.0,
                //横轴间距
                crossAxisSpacing: 8.0,
                //子组件宽高长度比例
                childAspectRatio: 1.0),
            shrinkWrap: true,
            itemCount: model.data.length,
            itemBuilder: (ctx, pos) {
              return GestureDetector(
                onTap: _showBigImageDialog(model.data[pos]),
                child: Container(
                    child: SuperImage.network(
                  model.data[pos],
                  fit: BoxFit.cover,
                  key: ValueKey(model.data[pos]),
                )),
              );
            },
          ),
          onRefresh: _onRefresh),
    );
  }

  Function _showBigImageDialog(String url) {
    return () => showDialog(
        context: context,
        builder: (ctx) {
          return _createBigImage(url);
        });
  }

  Widget _createBigImage(String url) {
    String fileName = url.substring(url.lastIndexOf("/") + 1, url.length);
    String shortUrl = url.substring(0, url.length - fileName.length - 1);
    String category =
        shortUrl.substring(shortUrl.lastIndexOf("/") + 1, shortUrl.length);
    String url1 =
        'https://w.wallhaven.cc/full/${category}/wallhaven-${fileName}';
    //原图URL
    String urlRetry = "${url1.substring(0, url1.lastIndexOf('.'))}.png";
    //PNG 后缀
    RetryImageController controller = RetryImageController([urlRetry], 1);

    return GestureDetector(
      onTap: () {
        print("click");
        Navigator.of(context).pop();
      },
      onLongPress: () {
        showDialog(
            context: context,
            builder: (ctx) {
              return new AlertDialog(title: new Text("保存"), actions: <Widget>[
                new FlatButton(
                  child: new Text("CANCEL"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    final file = File(FileProvider.getCacheDirPath() +
                        "/${_generateMd5(controller.state.src ?? url1)}");
                    final newPath = FileProvider.getExternalDir() +
                        "/${fileName}";
                    file.copy(newPath);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text("文件保存到${newPath}")));
                  },
                )
              ]);
            });
      },
      child: SuperImage.network(
        url1,
        controller: controller,
      ),
    );
  }

  Widget _createTypeTab() {
    return Center(
      child: RefreshIndicator(
        key: _refreshStateKey,
        child: ListView.builder(
            itemCount: model.data.length,
            itemBuilder: (ctx, pos) {
              if (pos == 0 && _type == TabType.TODAY) {
                return _createMeiziWall();
              }
              var data = model.data[pos];
              return createListViewItem(data);
            }),
        onRefresh: _onRefresh,
      ),
    );
  }

  Widget _createMeiziWall() {
    return Container(
      height: 220,
      child: PageView.builder(
        onPageChanged: (int page) => current = page,
        itemCount: model.gankMeizi.length,
        controller: controller,
        itemBuilder: (BuildContext ctx, pos) {
          return SuperImage.network(
            model.gankMeizi[pos]['url'],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  ///emmmmmmmmmmmmmmmmmmmmmmmmm
  Widget createListViewItem(data) => GestureDetector(
        onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DetailPage(data)))
            },
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

String _generateMd5(String data) {
  return md5.convert(utf8.encode(data)).toString();
}

import 'package:flutter/material.dart';
import 'package:gank_flutter/base/logger/logger.dart';
import 'package:gank_flutter/base/spider.dart';
import 'package:gank_flutter/base/status.dart';
import 'package:gank_flutter/ui/home/type.dart';

final spider = WallPaperSpider();

class HomeTabPage extends StatefulWidget {
  Status<TabType> _type;

  HomeTabPage(this._type) {}

  @override
  State<StatefulWidget> createState() {
    return _HomeTabPageState(_type);
  }
}

class _HomeTabPageState extends State<HomeTabPage> {
  final _strategy = Map();
  Status<TabType> _type;
  int length = 0;

  _HomeTabPageState(this._type) {
    _strategy
      ..[TabType.PRETTY] = createPrettyTab
      ..[TabType.ANDROID] = createAndroidTab
      ..[TabType.RECOMMEND] = createRecommendTab
      ..[TabType.FONT_END] = createFrontEndTab
      ..[TabType.BACK_END] = createBackEndTab
      ..[TabType.IOS] = createIosTab;
  }

  @override
  Widget build(BuildContext context) {
    return _strategy[_type.val]();
  }

  @override
  void initState() {
    () async {
      var set = await spider.getRandomWallPaper(1);
      logger.e(set);
      setState(() => {length += set.length});
    }();
  }

  Widget createPrettyTab() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: length,
      itemBuilder: (ctx, pos) {
        return Column(
          children: <Widget>[
            Text(spider.srcSet.toList()[pos]),
            Image.network(spider.srcSet.toList()[pos])],
        );
      },
    );
  }

  Widget createRecommendTab() {
    return Center(
      child: Text("GOOD"),
    );
  }

  Widget createAndroidTab() {}

  Widget createIosTab() {}

  Widget createFrontEndTab() {}

  Widget createBackEndTab() {}
}

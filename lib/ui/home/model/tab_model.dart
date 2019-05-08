import 'package:gank_flutter/base/logger/logger.dart';
import 'package:gank_flutter/base/net/okhttp.dart';
import 'package:gank_flutter/base/spider.dart';
import 'package:gank_flutter/ui/home/model/type.dart';

class TabModel {
  static final _okClient = OkHttpClient("http://gank.io/api");
  static final spider = WallPaperSpider();

  List data = [];
  int currentPage = 1;

  TabModel();

  Future loadTodayData() async {
    var temp = await _okClient.get("/today");
    var resp = await temp.toJsonObject();
    final results = resp["results"];

    for (final category in resp["category"]) {
      data.addAll((results[category]));
    }
  }

  Future<Set> loadMoreWallPaper(int page, [bool top = true]) async {
    Set loaded = await spider.getRandomWallPaper(page);
//    data.clear();
    if (top) {
      data.insertAll(0, loaded);
    } else {
      data.addAll(loaded);
    }
  }

  loadTypeData(TabType type) async {
    switch (type) {
      case TabType.TODAY:
        await loadTodayData();
        return;
      case TabType.PRETTY:
        await loadMoreWallPaper(1);
        return;
      default:
    }

    final temp = await _okClient.get("/data/${type.param}/10/$currentPage");
    var resp = await temp.toJsonObject();
    final results = resp["results"];
    data.addAll(results);
  }
}

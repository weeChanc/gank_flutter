import 'package:gank_flutter/base/logger/logger.dart';
import 'package:gank_flutter/base/net/okhttp.dart';
import 'package:gank_flutter/base/spider.dart';
import 'package:gank_flutter/ui/home/model/type.dart';

final _okClient = OkHttpClient("http://gank.io/api");
final _spider = WallPaperSpider();

class TabModel {
  List data = [];
  List gankMeizi = [];
  int _currentPage = 1;

  TabModel();

  Future<void> loadMoreWallPaper(int page, [bool top = true]) async {
    Set loaded = await _spider.getRandomWallPaper(page);
    if (top) {
      data.insertAll(0, loaded);
    } else {
      data.addAll(loaded);
    }
  }

  Future<void> loadTodayData() async {
    var temp = await _okClient.get("/today");
    var resp = await temp.toJsonObject();
    final results = resp["results"];

    for (final category in resp["category"]) {
      data.addAll((results[category]));
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

    final results = await _load(type.param, _currentPage);
    data.addAll(results);
  }

  int _meiziPage = 0;

  Future loadMeiziData() async {
    var result = await _load(TabType.PRETTY.param, _meiziPage);
    gankMeizi.addAll(result);
    _meiziPage++;
  }

  Future<List> _load(String type, int page) async {
    final temp = await _okClient.get("/data/${type}/10/$page");
    var resp = await temp.toJsonObject();
    final results = resp["results"];
    return results;
  }
}

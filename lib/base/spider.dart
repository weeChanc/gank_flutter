import 'net/okhttp.dart';

class WallPaperSpider {
  final _okClient = OkHttpClient("https://wallhaven.cc");

  Future getRandomWallPaper(int page) async {


    var resp = await _okClient.get("/search", {
      "categories": "010",
      "purity": "111",
      "sorting": "random",
      "order": "desc",
      "page": page
    });

    final html = await resp.plainText;
    var reg = RegExp('https://th.wallhaven.cc/.*?.jpg');
    var set = Set();
    for(Match m in reg.allMatches(html)){
      var src = html.substring(m.start,m.end);
      set.add(src);
    };

    return set;
  }
}

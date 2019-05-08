import 'net/okhttp.dart';

class WallPaperSpider {
  final _okClient = OkHttpClient("https://alpha.wallhaven.cc");

  Future getRandomWallPaper(int page) async {


    var resp = await _okClient.get("/search", {
      "q": "",
      "categories": "110",
      "purity": "010",
      "sorting": "random",
      "order": "desc",
      "page": page
    });

    final html = await resp.plainText;
    var reg = RegExp('https://alpha.wallhaven.cc/wallpapers/[-,/,0-9,a-zA-z]*.jpg');
    var set = Set();
    for(Match m in reg.allMatches(html)){
      var src = html.substring(m.start,m.end);
      set.add(src);
    };
    return set;
  }
}

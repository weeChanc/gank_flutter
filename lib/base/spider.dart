import 'net/okhttp.dart';

class WallPaperSpider {
  // spider of wallpaper heaven
  // https://alpha.wallhaven.cc/search?q=&categories=000&purity=110&sorting=random&order=desc&page=5
  // 010 yellow 010
  Set<String> srcSet = Set<String>();
  final _okClient = OkHttpClient("https://alpha.wallhaven.cc");

  Future getRandomWallPaper(int page) async {
    var resp = await _okClient.get("/search", {
      "q": "",
      "categories": "010",
      "purity": "010",
      "sorting": "random",
      "order": "desc",
      "page": page
    });

    final html = resp.content;
    var reg = RegExp('https://alpha.wallhaven.cc/wallpapers/[-,/,0-9,a-zA-z]*.jpg');
    var set = Set();
    for(Match m in reg.allMatches(html)){
      var src = html.substring(m.start,m.end);
      set.add(src);
      srcSet.add(src);
    };
    return set;
  }
}

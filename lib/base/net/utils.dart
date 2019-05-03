library util;

class Validater {
  static Map checkUrl(String url) {
    Uri uri = Uri.parse(url);
    return uri.queryParameters;
  }
}

class Converter {
  static String map2query(Map map) {
    if (map == null) return "";
    var str = "?";
    var params = List();
    map.forEach((k, v) =>
        {params.add("${k.toString()}=${v == null ? "" : v.toString()}")});
    return str + params.join("&");
  }
}

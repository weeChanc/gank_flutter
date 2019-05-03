import 'package:gank_flutter/base/logger/logger.dart';
import 'package:gank_flutter/base/net/okhttp.dart';

const base = "http://gank.io/api/";
const history = "day/history";

class PhotoModel {
  final _okClient = new OkHttpClient(base);
  Future getHistory() async {
    var resp = await _okClient.get(history);
    var json = resp.toJsonObject();
    return json;
  }
}

final photoModel = PhotoModel();

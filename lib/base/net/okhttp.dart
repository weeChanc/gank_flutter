library okhttp;

import 'dart:convert';
import 'dart:io';

import '../logger/logger.dart';
import './utils.dart';

typedef Interceptor = Response Function(Response);

class OkHttpClient {
  static final _mClient = HttpClient();

  String baseurl = "";
  Interceptor interceptor;

  OkHttpClient(this.baseurl, [this.interceptor]) {}

  Future<Response> get(String url, [Map params]) async {
    if (baseurl.isEmpty) {
      logger.e("baseurl is empty");
    }

    final originUrl = Uri.parse(baseurl + url);
    final path = Uri.parse(
        "${originUrl.scheme}://${originUrl.host}:${originUrl.port}${originUrl.path}" +
            "${Converter.map2query(params)}");

    logger.i("GET $path");

    try {
      final originResp = await _mClient.getUrl(path);
      final realResp = await originResp.close();
      final content = await realResp.transform(utf8.decoder).join();
      var resp = Response(content);
      if (interceptor != null) {
        resp = interceptor(resp);
      }
      return resp;
    } catch (e, s) {
      return Future.error(e, s);
    }
  }
}

class Response {
  String content;
  Object entity;
  Response(this.content);

  toJsonObject() {
    entity = JsonDecoder().convert(content);
    return entity;
  }
}

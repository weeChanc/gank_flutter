library okhttp;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import './utils.dart';
import '../logger/logger.dart';

typedef Interceptor = Response Function(Response);

class OkHttpClient {
  static final mClient = HttpClient();

  String baseurl = "";
  Interceptor interceptor;

  OkHttpClient([this.baseurl = "", this.interceptor]) {}

  Future<Response> get(String url, [Map params]) async {
    if (baseurl.isEmpty) {
//      logger.e("baseurl is empty");
    }

    if (url == null) {
      logger.e(" URL IS EMPTY");
      return null;
    }

    final originUrl = Uri.parse(baseurl + url);
    final path = Uri.parse(
        "${originUrl.scheme}://${originUrl.host}:${originUrl.port}${originUrl.path}" +
            "${Converter.map2query(params)}");

    logger.i("GET $path");

    try {
      final originResp = await mClient.getUrl(path);
      final realResp = await originResp.close();

      if (realResp.statusCode >= 404) {
        return Future.error(Exception("HTTP ERROR CODE: ${realResp.statusCode} "));
      }

      var resp = Response(realResp);
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
  HttpClientResponse _resp;

  Response(this._resp);

  Future<dynamic> toJsonObject() async {
    return JsonDecoder().convert(await plainText);
  }

  Future<List<int>> toIntArray() async {
    return await _resp.transform(
        StreamTransformer.fromHandlers(handleData: (v, EventSink<int> sink) {
      for (int i in v) {
        sink.add(i);
      }
    })).toList();
  }

  Future<Uint8List> toByteArray() async {
    List<int> intBuf = await toIntArray();
    Uint8List r = Uint8List.fromList(intBuf);
    return r;
  }

  Future<String> get plainText {
    return _resp.transform(utf8.decoder).join();
  }
}

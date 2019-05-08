import 'package:flutter/services.dart';

const webChannel = const MethodChannel("gank.flutter/web");

const platform = const Platform();

class Platform {
  static const _START_WEB_VIEW = "startWebView";

  const Platform();

  Future<T> openWebView<T>(String url) {
    return webChannel.invokeMethod<T>(_START_WEB_VIEW, url);
  }
}

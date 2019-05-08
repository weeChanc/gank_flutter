import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:gank_flutter/base/net/okhttp.dart';
import 'package:gank_flutter/platform/file_provider.dart';

class ImageCache {
  // FIFO queue
  final _memoryCache = Map<String, Uint8List>();
  final _externalDir = FileProvider.getCacheDirPath();
  final _httpClient = OkHttpClient();

  Future<Uint8List> loadImage(String src) async {
    Uint8List result;
    if ((result = loadFromMemory(src)) != null) return result;
    if ((result = await _loadFromDisk(src)) != null) return result;
    return addToMemCache(src, await _loadFromNetWork(src));
  }

  Uint8List addToMemCache(String url, Uint8List mem) {
    _memoryCache[_generateMd5(url)] = mem;
    _shrinkMap();
    return mem;
  }

  Uint8List loadFromMemory(String src) {
    return _memoryCache[_generateMd5(src)];
  }

  Future<Uint8List> _loadFromDisk(String src) async {
    final file = File(_externalDir + "/${_generateMd5(src)}");
    if (file.existsSync()) {
      List<int> result = await file.readAsBytes();
      return Uint8List.fromList(result);
    }
    return null;
  }

  Future<Uint8List> _loadFromNetWork(String src) async {
    Response resp = await _httpClient.get(src);
    // add to local cache
    var buf = await resp.toIntArray();
    final file = File(_externalDir + "/${_generateMd5(src)}");
    file.writeAsBytes(buf, flush: true);
    //
    return Uint8List.fromList(buf);
  }

  String _generateMd5(String data) {
    return md5.convert(utf8.encode(data)).toString();
  }

  void _shrinkMap() {
    if (_memoryCache.length < 50) return;

    var iter = _memoryCache.keys.toSet().iterator;
    while (iter.current != null) {
      if (_memoryCache.length > 50) {
        _memoryCache.remove(iter.current);
        iter.moveNext();
      } else {
        return;
      }
    }
  }
}

final cache = ImageCache();

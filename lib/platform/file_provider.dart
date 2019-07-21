import 'dart:io';

import 'package:gank_flutter/base/logger/logger.dart';

class FileProvider {
  static String getCacheDirPath() {
    Directory file = Directory("/storage/emulated/0/gankio/cache");
    file.create(recursive: true);
    return file.path;
  }

  static String getExternalDir() {
    Directory file = Directory("/storage/emulated/0/gankio/saved");
    file.create(recursive: true);
    return file.path;
  }
}
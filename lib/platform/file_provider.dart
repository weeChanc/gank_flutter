import 'dart:io';

import 'package:gank_flutter/base/logger/logger.dart';

class FileProvider {
  static String getCacheDirPath() {
    Directory file = Directory("/storage/emulated/0/gankio");
    file.create(recursive: true);
    logger.e(file.existsSync());
    return file.path;
  }
}
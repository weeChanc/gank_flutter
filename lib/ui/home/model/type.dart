import 'package:gank_flutter/base/logger/logger.dart';

class TabType {
  final int id;
  final String name;
  final String param;

  const TabType(this.id, this.name,this.param);

  static const TabType TODAY = const TabType(0, "今日","今日");
  static const TabType FONT_END = const TabType(1, "前端","前端");
  static const TabType ANDROID = const TabType(2, "安卓","Android");
  static const TabType IOS = const TabType(3, "苹果","iOS");
  static const TabType BACK_END = const TabType(4, "后端",null);
  static const TabType PRETTY = const TabType (5,"福利",null);


}

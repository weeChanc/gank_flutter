import 'package:gank_flutter/base/logger/logger.dart';

class TabType {
  final int id;
  final String name;

  const TabType(this.id, this.name);

  static const TabType RECOMMEND = const TabType(0, "推荐");
  static const TabType FONT_END = const TabType(1, "前端");
  static const TabType ANDROID = const TabType(2, "安卓");
  static const TabType IOS = const TabType(3, "苹果");
  static const TabType BACK_END = const TabType(4, "后端");
  static const TabType PRETTY = const TabType (5,"福利");

  bool operator ==(other) {
    if(! (other is TabType)) return false;
    return this.id == other.id && this.name == other.name;
  }

  @override
  int get hashCode {
    int result = 17;
    result = 31 * result + identityHashCode(id);
    result = 31 * result + identityHashCode(name);
    return result;
  }


}

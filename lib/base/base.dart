library base;

import 'package:flutter/widgets.dart';

export 'package:flutter/widgets.dart';
export 'package:gank_flutter/base/logger/logger.dart';

abstract class BaseWidget extends Widget {}

abstract class BaseStatefulWidget extends StatefulWidget {}

abstract class BaseState<T extends BaseStatefulWidget> extends State<T> {
  @override
  void setState(VoidCallback fn) {
    if (this.mounted) {
      super.setState(fn);
    }
  }




}

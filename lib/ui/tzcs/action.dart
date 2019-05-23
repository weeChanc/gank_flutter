import 'package:fish_redux/fish_redux.dart';
import 'package:gank_flutter/ui/tzcs/state.dart';

enum PhyAction { submit }

class PhyActionCreator {
  static Action submit(PhyState state) {
    return Action(PhyAction.submit, payload: state);
  }
}

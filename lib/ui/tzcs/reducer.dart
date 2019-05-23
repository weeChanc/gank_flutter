
import 'package:fish_redux/fish_redux.dart';
import 'package:gank_flutter/ui/tzcs/state.dart';
import 'action.dart';

Reducer<PhyState> buildReducer(){
    return asReducer(<Object,Reducer<PhyState>>{
      PhyAction.submit:  _submit
    });
}

PhyState _submit(PhyState state, Action action){

}
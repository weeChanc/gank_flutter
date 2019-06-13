//import 'package:flutter/material.dart';
//import 'package:tencentedu/common/widgets/status_indicator.dart';
//
//enum PageStatus { Loading, Error, Empty, Normal, NoNetwork }
//
/////带有状态的page
//class StatusPage extends StatefulWidget {
//  /// 加载错误时应该显示的widget
//  StatusIndicator error;
//
//  /// 用来构建正常状态widget的builder
//  WidgetBuilder normalWidgetBuilder;
//
//  ///用来构建actionbar的builder，如果没有actionbar或者actionbar不参与状态管理则不传
//  WidgetBuilder actionBarBuilder;
//
//  /// 页面加载时显示的widget
//  StatusIndicator loading;
//
//  ///页面无数据时显示的widget
//  StatusIndicator empty;
//
//  ///无网络时显示的widget，需要手动管理，这里没有判断是否有网
//  StatusIndicator noNetwork;
//
//  ///手动切换状态的controller  {error,normal,empty,loading,noNetwork}
//  StatusController statusController;
//
//  ///状态变化的回调，要根据状态变化作出响应则传入
//  StatusCallback statusCallback;
//
//  StatusPage(
//      {StatusIndicator error,
//        this.normalWidgetBuilder,
//        this.actionBarBuilder,
//        StatusIndicator loading,
//        StatusIndicator empty,
//        StatusIndicator noNetwork,
//        @required this.statusController,
//        @required this.statusCallback})
//      : assert(statusController != null),
//        assert(statusCallback != null),
//        this.error = error ?? ErrorStatusIndicator(),
//        this.loading = loading ?? LoadingStatusIndicator(),
//        this.empty = empty ?? EmptyStatusIndicator(),
//        this.noNetwork = noNetwork ?? NoNetworkStatusIndicator() {
//    this.error.onTap = () {
//      statusController.loading();
//    };
//    this.noNetwork.onTap = () {
//      statusController.loading();
//    };
//  }
//
//  @override
//  State<StatefulWidget> createState() {
//    return StatusPageState();
//  }
//}
//
//class StatusPageState extends State<StatusPage> {
//  VoidCallback _statusListener;
//
//  @override
//  void initState() {
//    super.initState();
//    _statusListener = () {
//      setState(() {});
//    };
//    widget.statusController._addListener(_statusListener);
//    widget.statusController.statusCallBack = widget.statusCallback;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    print('xiaobuji build status page');
//    Widget body;
//    switch (widget.statusController.getCurrentStatus()) {
//      case PageStatus.Error:
//        body = widget.error;
//        break;
//      case PageStatus.Normal:
//        body = widget.normalWidgetBuilder(context);
//        break;
//      case PageStatus.Empty:
//        body = widget.empty;
//        break;
//      case PageStatus.Loading:
//        body = widget.loading;
//        break;
//      case PageStatus.NoNetwork:
//        body = widget.noNetwork;
//        break;
//    }
//    return CustomMultiChildLayout(
//      delegate: _StatusPageLayoutDelegate(),
//      children: () {
//        List<Widget> list = <Widget>[
//          LayoutId(
//            id: _StatusPageLayoutDelegate.body,
//            child: body,
//          ),
//        ];
//        //有actionbar就加进来
//        if (widget.actionBarBuilder != null) {
//          list.insert(
//              0,
//              LayoutId(
//                id: _StatusPageLayoutDelegate.actionBar,
//                child: widget.actionBarBuilder(context),
//              ));
//        }
//        return list;
//      }(),
//    );
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    print('xiaobuji  status page dispose');
//    widget.statusController._removeListener(_statusListener);
//    widget.statusController._removeStatusCallback();
//  }
//}
//
//
//
//class StatusController {
//  set statusCallBack(StatusCallback callback) {
//    _statusCallBack = callback;
//    _pageStatus.addListener(() {
//      print("xiaobuji ${_pageStatus.value}");
//      if (_statusCallBack == null) {
//        return;
//      }
//
//      switch (_pageStatus.value) {
//        case PageStatus.Error:
//          _statusCallBack.onErrorStatus();
//          break;
//        case PageStatus.NoNetwork:
//          _statusCallBack.onNoNetworkStatus();
//          break;
//        case PageStatus.Normal:
//          _statusCallBack.onNormalStatus();
//          break;
//        case PageStatus.Empty:
//          _statusCallBack.onEmptyStatus();
//          break;
//        case PageStatus.Loading:
//          _statusCallBack.onLoadStatus();
//          break;
//      }
//    });
//  }
//
//  StatusCallback _statusCallBack;
//
//  StatusController({@required initStatus}) {
//    _pageStatus = StickyValueNotifier(initStatus);
//  }
//
//  ValueNotifier<PageStatus> _pageStatus;
//
//  void _removeStatusCallback() {
//    _statusCallBack = null;
//  }
//
//  void _addListener(VoidCallback listener) {
//    _pageStatus.addListener(listener);
//  }
//
//  void _removeListener(VoidCallback listener) {
//    _pageStatus.removeListener(listener);
//  }
//
//  void error() => _pageStatus.value = PageStatus.Error;
//
//  void normal() => _pageStatus.value = PageStatus.Normal;
//
//  void loading() => _pageStatus.value = PageStatus.Loading;
//
//  void empty() => _pageStatus.value = PageStatus.Empty;
//
//  void noNetwork() => _pageStatus.value = PageStatus.NoNetwork;
//
//  PageStatus getCurrentStatus() => _pageStatus.value;
//}
//
//abstract class StatusCallback {
//  void onLoadStatus();
//
//  void onEmptyStatus();
//
//  void onNormalStatus();
//
//  void onErrorStatus();
//
//  void onNoNetworkStatus();
//}
//
/////定制的ValueNotifier
/////1.增加粘性支持
/////2.改为新旧value相同时也notify
//class StickyValueNotifier<T> extends ValueNotifier<T> {
//  StickyValueNotifier(T value) : super(value);
//
//  @override
//  void addListener(listener) {
//    super.addListener(listener);
//    listener();
//  }
//
//  @override
//  set value(T newValue) {
//    //不管value是否相同，设置就通知
//    T oldValue = value;
//    super.value = newValue;
//    if (oldValue == newValue) {
//      notifyListeners();
//    }
//  }
//}
//
//class _StatusPageLayoutDelegate extends MultiChildLayoutDelegate {
//  static const String actionBar = 'action_bar';
//  static const String body = 'body';
//
//  @override
//  void performLayout(Size size) {
//    Size actionBarSize = layoutChild(actionBar,
//        BoxConstraints(maxHeight: size.height, maxWidth: size.width));
//    positionChild(actionBar, Offset(0.0, 0.0));
//    layoutChild(body, BoxConstraints.tight(Size(size.width, size.height)));
//    positionChild(body, Offset(0.0, actionBarSize.height));
//  }
//
//  @override
//  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
//    return false;
//  }
//}
//
//
//class StatusController {
//  set statusCallBack(StatusCallback callback) {
//    _statusCallBack = callback;
//    _pageStatus.addListener(() {
//      print("xiaobuji ${_pageStatus.value}");
//      if (_statusCallBack == null) {
//        return;
//      }
//
//      switch (_pageStatus.value) {
//        case PageStatus.Error:
//          _statusCallBack.onErrorStatus();
//          break;
//        case PageStatus.NoNetwork:
//          _statusCallBack.onNoNetworkStatus();
//          break;
//        case PageStatus.Normal:
//          _statusCallBack.onNormalStatus();
//          break;
//        case PageStatus.Empty:
//          _statusCallBack.onEmptyStatus();
//          break;
//        case PageStatus.Loading:
//          _statusCallBack.onLoadStatus();
//          break;
//      }
//    });
//  }
//
//  StatusCallback _statusCallBack;
//
//  StatusController({@required initStatus}) {
//    _pageStatus = StickyValueNotifier(initStatus);
//  }
//
//  ValueNotifier<PageStatus> _pageStatus;
//
//  void _removeStatusCallback() {
//    _statusCallBack = null;
//  }
//
//  void _addListener(VoidCallback listener) {
//    _pageStatus.addListener(listener);
//  }
//
//  void _removeListener(VoidCallback listener) {
//    _pageStatus.removeListener(listener);
//  }
//
//  void error() => _pageStatus.value = PageStatus.Error;
//
//  void normal() => _pageStatus.value = PageStatus.Normal;
//
//  void loading() => _pageStatus.value = PageStatus.Loading;
//
//  void empty() => _pageStatus.value = PageStatus.Empty;
//
//  void noNetwork() => _pageStatus.value = PageStatus.NoNetwork;
//
//  PageStatus getCurrentStatus() => _pageStatus.value;
//}
//
//abstract class StatusCallback {
//  void onLoadStatus();
//
//  void onEmptyStatus();
//
//  void onNormalStatus();
//
//  void onErrorStatus();
//
//  void onNoNetworkStatus();
//}
//
/////定制的ValueNotifier
/////1.增加粘性支持
/////2.改为新旧value相同时也notify
//class StickyValueNotifier<T> extends ValueNotifier<T> {
//  StickyValueNotifier(T value) : super(value);
//
//  @override
//  void addListener(listener) {
//    super.addListener(listener);
//    listener();
//  }
//
//  @override
//  set value(T newValue) {
//    //不管value是否相同，设置就通知
//    T oldValue = value;
//    super.value = newValue;
//    if (oldValue == newValue) {
//      notifyListeners();
//    }
//  }
//}
//
//class _StatusPageLayoutDelegate extends MultiChildLayoutDelegate {
//  static const String actionBar = 'action_bar';
//  static const String body = 'body';
//
//  @override
//  void performLayout(Size size) {
//    Size actionBarSize = layoutChild(actionBar,
//        BoxConstraints(maxHeight: size.height, maxWidth: size.width));
//    positionChild(actionBar, Offset(0.0, 0.0));
//    layoutChild(body, BoxConstraints.tight(Size(size.width, size.height)));
//    positionChild(body, Offset(0.0, actionBarSize.height));
//  }
//
//  @override
//  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
//    return false;
//  }
//}
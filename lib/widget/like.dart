import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Like extends StatefulWidget {
  @override
  State createState() {
    return _State();
  }
}

class _State extends State<Like> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Transform(transform: Matrix4.diagonal3Values(_controller.value,_controller.value,_controller.value) , child : Image.asset("asset/image/love.png",key: GlobalKey(),))
    );
  }

  @override
  void initState() {
    _controller =
    AnimationController(vsync: this, duration: Duration(milliseconds: 3500),)
      ..repeat()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
  }

}

class _Heart extends CustomPainter {
  double _radius;

  final _mPaint = Paint();

  _Heart(double radius) {
    this._radius = radius;
    _mPaint.color = Colors.red;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(32, 32), _radius, _mPaint);
  }



  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

import 'package:flutter/material.dart';
import 'package:gank_flutter/base/base.dart';

import 'image_loader.dart';

/// only support network ~
class SuperImage extends BaseStatefulWidget {
  final double width;
  final double height;
  final Color color;
  final FilterQuality filterQuality;
  final BlendMode colorBlendMode;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final Rect centerSlice;
  final bool matchTextDirection;
  final bool gaplessPlayback;
  final String semanticLabel;
  final bool excludeFromSemantics;
  final Key key;
  final num scale;
  final String src;

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

  SuperImage.network(
    this.src, {
    this.key,
    this.scale = 1.0,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.filterQuality = FilterQuality.low,
  });
}

class _State extends BaseState<SuperImage> {
  var buf = null;

  _State();

  @override
  void initState() {
    cache.loadImage(this.widget.src).then((buf) {
      setState(() => this.buf = buf);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (buf == null)
      return Container(
        width: widget.width,
        height: widget.height,
        child: Center(child: CircularProgressIndicator()),
      );
    return Image.memory(buf,
        width: this.widget.width,
        height: widget.height,
        color: widget.color,
        filterQuality: widget.filterQuality,
        colorBlendMode: widget.colorBlendMode,
        fit: widget.fit,
        alignment: widget.alignment,
        repeat: widget.repeat,
        centerSlice: widget.centerSlice,
        matchTextDirection: widget.matchTextDirection,
        gaplessPlayback: widget.gaplessPlayback,
        semanticLabel: widget.semanticLabel,
        excludeFromSemantics: widget.excludeFromSemantics,
        key: widget.key,
        scale: widget.scale);
  }
}
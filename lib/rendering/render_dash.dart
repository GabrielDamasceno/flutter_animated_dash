import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';

class RenderDash extends RenderBox {
  RenderDash({
    required Animation<double> wings,
    required Animation<double> position,
  })  : _wings = wings,
        _position = position;

  late Animation<double> _wings;
  Animation<double> get wings => _wings;
  set wings(Animation<double> newValue) {
    if (_wings == newValue) return;

    if (attached) _wings.removeListener(markNeedsPaint);
    _wings = newValue;
    if (attached) _wings.addListener(markNeedsPaint);
    markNeedsPaint();
  }

  late Animation<double> _position;
  Animation<double> get position => _position;
  set position(Animation<double> newValue) {
    if (_position == newValue) return;

    if (attached) _position.removeListener(markNeedsPaint);
    _position = newValue;
    if (attached) _position.addListener(markNeedsPaint);
    markNeedsPaint();
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    wings.addListener(markNeedsPaint);
    position.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    wings.removeListener(markNeedsPaint);
    position.removeListener(markNeedsPaint);
    super.detach();
  }

  static const Color _wingsColor = Color(0xff0d7bb8);
  static const Color _tailColor = Color(0xff0d7bb8);
  static const Color _bodyColor = Color(0xff2aa2de);
  static const Color _nozzleColor = Color(0xff787677);
  static const Size _minDesiredSize = Size(50.0, 50.0);

  @override
  bool get isRepaintBoundary => true;

  @override
  bool get sizedByParent => true;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return constraints.constrain(_minDesiredSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Paint nozzlePaint = Paint()..color = _nozzleColor;
    final Paint neckPaint = Paint()..color = _bodyColor;
    final Paint bodyPaint = Paint()..color = _bodyColor;
    final Paint tailPaint = Paint()..color = _tailColor;
    final Paint wingPaint = Paint()..color = _wingsColor;

    final double insets = size.width * 0.015;
    final Offset center = Offset(size.width / 2, size.height / 2);

    final Path nozzle = _getNozzlePath(origin: Offset.zero);
    final Rect nozzleBounds = nozzle.getBounds();
    final Path neck = _getNeckPath(nozzleBounds: nozzleBounds, insets: insets);
    final Rect neckBounds = neck.getBounds();
    final Path body = _getBodyPath(neckBounds: neckBounds, insets: insets);
    final Rect bodyBounds = body.getBounds();
    final Path tail = _getTailPath(bodyBounds: bodyBounds, insets: insets);

    final Offset firstWingO1 = Offset(
      (bodyBounds.left - insets),
      (bodyBounds.bottom - (size.height * 0.182)),
    );
    final Offset secondWingO1 = Offset(
      bodyBounds.left + (insets * 2.4),
      bodyBounds.bottom - (size.height * 0.26),
    );

    final Path wing1 = _getWingPath(
      o1: firstWingO1,
      o2WFactor: 0.175,
      o2HFactor: 0.39,
      d2XFactor: 0.5,
      d2YFactor: 0.05,
      o3XFactor: 1.6,
      o3YFactor: 10.0,
    );

    final Path wing2 = _getWingPath(
      o1: secondWingO1,
      o2WFactor: 0.3,
      o2HFactor: 0.27,
      d2XFactor: 0.49,
      d2YFactor: 0.16,
      o3XFactor: 1.58,
      o3YFactor: 2.7,
    );

    context.canvas
      ..transform(_getTransformation(center).storage)
      ..drawPath(nozzle, nozzlePaint)
      ..drawPath(neck, neckPaint)
      ..drawPath(wing2, wingPaint)
      ..drawPath(body, bodyPaint)
      ..drawPath(wing1, wingPaint)
      ..drawPath(tail, tailPaint);
  }

  Matrix4 _getTransformation(Offset origin) {
    return Matrix4.identity()
      ..translate(origin.dx, origin.dy)
      ..rotateZ(pi / 7)
      ..translate(5.5 * position.value, 5.5 * position.value)
      ..translate(-origin.dx, -origin.dy);
  }

  Path _getNozzlePath({required Offset origin}) {
    return Path()
      ..moveTo(
        origin.dx + size.width,
        origin.dy + (size.height * 0.1),
      )
      ..relativeLineTo(
        -size.width * 0.34,
        0.0,
      )
      ..relativeLineTo(
        size.width * 0.04,
        size.height * 0.07,
      )
      ..close();
  }

  Path _getNeckPath({
    required Rect nozzleBounds,
    required double insets,
  }) {
    return Path()
      ..moveTo(
        nozzleBounds.left - insets,
        nozzleBounds.top,
      )
      ..relativeLineTo(
        size.width * 0.04,
        size.height * 0.07,
      )
      ..relativeLineTo(
        -size.width * 0.132,
        -size.height * 0.0078,
      )
      ..close();
  }

  Path _getBodyPath({
    required Rect neckBounds,
    required double insets,
  }) {
    return Path()
      ..moveTo(
        neckBounds.right + (size.width * 0.03),
        neckBounds.bottom + insets,
      )
      ..relativeLineTo(
        -size.width * 0.18,
        -size.height * 0.012,
      )
      ..relativeLineTo(
        -size.width * 0.18,
        size.height * 0.40,
      )
      ..relativeLineTo(
        size.width * 0.16,
        size.height * 0.17,
      )
      ..relativeLineTo(
        size.width * 0.19,
        -size.height * 0.17,
      )
      ..close();
  }

  Path _getTailPath({
    required Rect bodyBounds,
    required double insets,
  }) {
    return Path()
      ..moveTo(
        bodyBounds.right - (size.width * 0.212),
        bodyBounds.bottom + insets,
      )
      ..relativeLineTo(
        -size.width * 0.115,
        -size.height * 0.125,
      )
      ..relativeLineTo(
        -size.width * 0.115,
        size.height * 0.35,
      )
      ..close();
  }

  Path _getWingPath({
    required Offset o1,
    required double o2WFactor,
    required double o2HFactor,
    required double d2XFactor,
    required double d2YFactor,
    required double o3XFactor,
    required double o3YFactor,
  }) {
    final Offset o2 = o1.translate(
      size.width * o2WFactor,
      -size.height * o2HFactor,
    );
    final double d2X = size.width * d2XFactor;
    final double d2Y = size.height * d2YFactor;
    final Offset startO3 = o2.translate(-d2X, -d2Y);
    final Offset endO3 = startO3.translate(d2X * o3XFactor, d2Y * o3YFactor);
    final Offset lerpO3 = Offset.lerp(startO3, endO3, _wings.value)!;

    return Path()
      ..moveTo(o1.dx, o1.dy)
      ..lineTo(o2.dx, o2.dy)
      ..lineTo(lerpO3.dx, lerpO3.dy)
      ..close();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animated_dash/rendering/render_dash.dart';

class RenderDashWidget extends LeafRenderObjectWidget {
  final Animation<double> wings;
  final Animation<double> position;

  const RenderDashWidget({
    super.key,
    required this.wings,
    required this.position,
  });

  @override
  RenderDash createRenderObject(BuildContext context) {
    return RenderDash(
      wings: wings,
      position: position,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderDash renderObject,
  ) {
    renderObject
      ..wings = wings
      ..position = position;
  }
}

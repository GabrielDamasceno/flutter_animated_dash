import 'package:flutter/material.dart';
import 'package:flutter_animated_dash/widgets/render_dash_widget.dart';

class AnimatedDash extends StatefulWidget {
  const AnimatedDash({super.key});

  @override
  State<AnimatedDash> createState() => _AnimatedDashState();
}

class _AnimatedDashState extends State<AnimatedDash>
    with SingleTickerProviderStateMixin {
  late final AnimationController _movementController;
  late final Animation<double> _wings;
  late final Animation<double> _position;

  @override
  void initState() {
    super.initState();

    _movementController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _wings = _getWingsSequence().animate(_movementController);
    _position = _getPositionSequence().animate(_movementController);
    _movementController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _movementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: 180.0,
        child: RenderDashWidget(
          wings: _wings,
          position: _position,
        ),
      ),
    );
  }

  TweenSequence<double> _getWingsSequence() {
    return TweenSequence<double>(
      [
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          weight: 4.0,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 0.0),
          weight: 4.0,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          weight: 4.0,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 0.0),
          weight: 4.0,
        ),
        TweenSequenceItem(
          tween: ConstantTween(0.0),
          weight: 20,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          weight: 5.0,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 0.0),
          weight: 5.0,
        ),
        TweenSequenceItem(
          tween: ConstantTween(0.0),
          weight: 15,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          weight: 5.0,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 0.0),
          weight: 5.0,
        ),
      ],
    );
  }

  TweenSequence<double> _getPositionSequence() {
    return TweenSequence<double>(
      [
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: 0.5),
          weight: 4.0,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.5, end: 0.0),
          weight: 4.0,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: 0.5),
          weight: 4.0,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.5, end: 0.0),
          weight: 4.0,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          weight: 20,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 0.5),
          weight: 5.0,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.5, end: 0.0),
          weight: 5.0,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          weight: 15,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 0.0),
          weight: 5.0,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          weight: 5.0,
        ),
      ],
    );
  }
}

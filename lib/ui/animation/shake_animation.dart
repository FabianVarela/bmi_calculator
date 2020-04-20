import 'package:flutter/material.dart';

class ShakeAnimation extends StatefulWidget {
  ShakeAnimation({
    @required this.child,
    this.durationSeconds = 1,
    this.begin = 16,
    this.end = 0,
  });

  final Widget child;
  final int durationSeconds;
  final double begin;
  final double end;

  @override
  _ShakeAnimationState createState() => _ShakeAnimationState();
}

class _ShakeAnimationState extends State<ShakeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationSeconds),
    );

    _shakeAnimation = Tween<double>(begin: widget.begin, end: widget.end)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_animationController)
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed)
              _animationController.reverse();
            else if (status == AnimationStatus.dismissed)
              _animationController.forward();
          });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (_, Widget child) {
        return Padding(
          padding: EdgeInsets.only(
            left: _shakeAnimation.value + 24,
            right: 24 - _shakeAnimation.value,
          ),
          child: widget.child,
        );
      },
    );
  }
}

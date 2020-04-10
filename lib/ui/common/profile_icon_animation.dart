import 'package:flutter/material.dart';

class ProfileIconAnimation extends StatefulWidget {
  ProfileIconAnimation({@required this.durationSeconds, this.onPressed});

  final int durationSeconds;
  final Function onPressed;

  @override
  _ProfileIconAnimationState createState() => _ProfileIconAnimationState();
}

class _ProfileIconAnimationState extends State<ProfileIconAnimation>
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

    _shakeAnimation = Tween<double>(begin: 0.0, end: 24.0)
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
          child: IconButton(
            onPressed: widget.onPressed ?? () {},
            padding: EdgeInsets.zero,
            icon: Icon(Icons.account_circle, size: 40),
          ),
        );
      },
    );
  }
}

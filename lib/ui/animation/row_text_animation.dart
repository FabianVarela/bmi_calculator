import 'dart:math';

import 'package:flutter/material.dart';

class RowTextAnimation extends StatefulWidget {
  RowTextAnimation({
    @required this.text,
    this.color = Colors.white,
    this.fontSize = 14,
  });

  final String text;
  final Color color;
  final double fontSize;

  @override
  _RowTextAnimationState createState() => _RowTextAnimationState();
}

class _RowTextAnimationState extends State<RowTextAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;
  List<String> _charList;

  @override
  void initState() {
    super.initState();
    _charList = widget.text.split('');

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        Future<void>.delayed(Duration(milliseconds: 800), () {
          _controller.forward(from: 0.0);
        });
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(_charList.length, (int index) {
        final Animation<double> animation = _initAnimation(index);

        return AnimatedBuilder(
          animation: animation,
          builder: (_, Widget child) => Opacity(
            opacity: animation.value,
            child: child,
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Text(
              _charList[index],
              style: TextStyle(
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w700,
                color: widget.color,
              ),
            ),
          ),
        );
      }),
    );
  }

  Animation<double> _initAnimation(int index) {
    final double startTime = 0.4;
    final double durationTime = 0.5;

    final double begin = startTime * index / _charList.length;
    final double end = begin + durationTime;

    return SinusoidalAnimation(min: 0.3, max: 0.8).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(begin, end),
    ));
  }
}

class SinusoidalAnimation extends Animatable<double> {
  SinusoidalAnimation({this.min, this.max});

  final double min;
  final double max;

  @override
  double transform(double t) => min + (max - min) * sin(pi * t);
}

import 'package:flutter/material.dart';

class IntervalColumnBottomAnimation extends StatefulWidget {
  IntervalColumnBottomAnimation({
    @required this.children,
    @required this.height,
  });

  final List<Widget> children;
  final double height;

  @override
  _IntervalColumnBottomAnimationState createState() =>
      _IntervalColumnBottomAnimationState();
}

class _IntervalColumnBottomAnimationState
    extends State<IntervalColumnBottomAnimation> with TickerProviderStateMixin {
  AnimationController _controller;
  List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1100),
    );

    _animations = widget.children.map((Widget item) {
      final int index = widget.children.indexOf(item);

      final double start = index * .1;
      final double duration = .6;
      final double end = duration + start;

      return Tween<double>(begin: widget.height, end: 0.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.decelerate),
        ),
      );
    }).toList();

    Future<void>.delayed(
        Duration(milliseconds: 1000), () => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widget.children.map((Widget item) {
        final int index = widget.children.indexOf(item);
        return AnimatedBuilder(
          animation: _controller,
          child: item,
          builder: (_, Widget child) {
            return Transform.translate(
              offset: Offset(0.0, _animations[index].value),
              child: child,
            );
          },
        );
      }).toList(),
    );
  }
}

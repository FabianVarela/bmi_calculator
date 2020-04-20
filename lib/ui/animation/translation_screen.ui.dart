import 'dart:math';

import 'package:flutter/material.dart';

class TransitionScreen extends AnimatedWidget {
  TransitionScreen({@required this.listenable}) : super(listenable: listenable);

  final Listenable listenable;

  Animation<int> get _dotPosition => IntTween(begin: 0, end: 50).animate(
      CurvedAnimation(parent: super.listenable, curve: Interval(.15, .3)));

  Animation<double> get expandingSize => ExpandingAnimation().animate(
      CurvedAnimation(parent: super.listenable, curve: Interval(.3, .8)));

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double width = min(expandingSize.value, deviceWidth);

    return IgnorePointer(
      child: Opacity(
        opacity: _dotPosition.value > 0 ? 1 : 0,
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Spacer(flex: 104 - _dotPosition.value),
                Container(
                  height: expandingSize.value,
                  width: expandingSize.value,
                  margin: EdgeInsets.only(
                      bottom: width < 0.9 * deviceWidth ? 36 : 0),
                  decoration: BoxDecoration(
                    shape: width < 0.9 * deviceWidth
                        ? BoxShape.circle
                        : BoxShape.rectangle,
                    color: Colors.indigo,
                  ),
                ),
                Spacer(flex: 4 + _dotPosition.value),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExpandingAnimation extends Animatable<double> {
  final double defaultSize = 52.0;
  final double expansionRange = 30.0;
  final int numberOfCycles = 2;
  final double fullExpansionEdge = 0.8;

  @override
  double transform(double t) {
    if (t < fullExpansionEdge) {
      return defaultSize;
    } else {
      final double normalizedT =
          (t - fullExpansionEdge) / (1 - fullExpansionEdge);
      return defaultSize + normalizedT * 2000.0;
    }
  }
}

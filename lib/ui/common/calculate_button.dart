import 'package:bmi_calculator/ui/animation/row_text_animation.dart';
import 'package:bmi_calculator/ui/utils/responsive.dart';
import 'package:flutter/material.dart';

class CalculateButton extends StatefulWidget {
  CalculateButton({
    @required this.animationController,
    @required this.onPressedCalculateBMI,
    this.backgroundColor = Colors.blue,
    this.color = Colors.white,
  });

  final AnimationController animationController;
  final Function onPressedCalculateBMI;
  final Color backgroundColor;
  final Color color;

  @override
  _CalculateButtonState createState() => _CalculateButtonState();
}

class _CalculateButtonState extends State<CalculateButton> {
  Animation<BorderRadius> _borderRadiusAnimation;
  Animation<double> _widthAnimation;

  double get _width => _widthAnimation?.value ?? 0.0;

  @override
  void initState() {
    super.initState();

    _borderRadiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(8),
      end: BorderRadius.circular(50),
    ).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(0.0, 0.07),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        _widthAnimation = Tween<double>(
          begin: constraints.maxWidth,
          end: 54,
        ).animate(CurvedAnimation(
          parent: widget.animationController,
          curve: Interval(0.05, 0.15),
        ));

        return AnimatedBuilder(
          animation: widget.animationController,
          builder: (_, Widget child) {
            return Center(
              child: Container(
                height: Responsive.getInstance().setHeight(54),
                width: _width,
                child: RaisedButton(
                  onPressed: _widthAnimation.isDismissed
                      ? widget.onPressedCalculateBMI
                      : () {},
                  color: widget.backgroundColor,
                  padding: EdgeInsets.symmetric(
                    vertical: Responsive.getInstance().setHeight(15),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: _borderRadiusAnimation.value,
                  ),
                  child: _widthAnimation.isDismissed
                      ? RowTextAnimation(
                          text: 'Calculate',
                          color: widget.color,
                          fontSize: Responsive.getInstance().setSp(20),
                          fontWeight: FontWeight.w700,
                        )
                      : Container(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

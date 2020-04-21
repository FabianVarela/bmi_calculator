import 'package:bmi_calculator/ui/utils/responsive.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    @required this.title,
    @required this.child,
    this.padding = const EdgeInsets.all(10),
    this.subtitle,
    this.message,
  });

  final String title;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final String subtitle;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: Responsive.getInstance().setSp(16),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            child,
            if (title != null && message != null)
              Column(
                children: <Widget>[
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: Responsive.getInstance().setSp(16),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: Responsive.getInstance().setSp(14),
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    @required this.title,
    @required this.child,
    this.padding = const EdgeInsets.all(10),
  });

  final String title;
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 12),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

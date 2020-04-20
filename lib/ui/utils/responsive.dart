import 'package:flutter/material.dart';

class Responsive {
  static Responsive instance = Responsive();

  double width;
  double height;

  bool allowFontScaling;

  static double _screenWidth;
  static double _screenHeight;
  static double _textScaleFactor;

  Responsive({
    this.width = 1080,
    this.height = 1920,
    this.allowFontScaling = false,
  });

  static Responsive getInstance() => instance;

  void init(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  double get scaleWidth => _screenWidth / instance.width;

  double get scaleHeight => _screenHeight / instance.height;

  double setWidth(double width) => width * scaleWidth;

  double setHeight(double height) => height * scaleHeight;

  double setSp(double fontSize) => allowFontScaling
      ? setWidth(fontSize)
      : setWidth(fontSize) / _textScaleFactor;
}

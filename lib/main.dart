import 'package:bmi_calculator/ui/home.ui.dart';
import 'package:bmi_calculator/ui/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI',
      theme: ThemeData(fontFamily: 'FiraSans'),
      home: Builder(builder: (BuildContext context) {
        final double width = MediaQuery.of(context).size.width;
        final double height = MediaQuery.of(context).size.height;

        Responsive.instance = Responsive(width: width, height: height)
          ..init(context);

        return HomeBMI();
      }),
    );
  }
}

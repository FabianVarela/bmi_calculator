import 'package:bmi_calculator/ui/common/custom_clip_path.dart';
import 'package:bmi_calculator/ui/common/interval_column_bottom_animation.dart';
import 'package:flutter/material.dart';

class ResultUI extends StatefulWidget {
  @override
  _ResultUIState createState() => _ResultUIState();
}

class _ResultUIState extends State<ResultUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipPath(),
            child: Container(
              color: Colors.indigo,
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(height: MediaQuery.of(context).size.height),
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.fromLTRB(24, 50, 24, 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: IntervalColumnBottomAnimation(
                duration: Duration(milliseconds: 800),
                height: MediaQuery.of(context).size.height,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      'BMI final result',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 20,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Text(
                        '22.4',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Overweight',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'BMI = 22.93 kg/m2',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'BMI weight range for the height:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          '128.9 lbs - 174.2 lbs',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _setIconButton(Icons.delete, () {}),
                      _setIconButton(Icons.refresh, () {}, isCircle: true),
                      _setIconButton(Icons.share, () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _setIconButton(IconData icon, Function function,
      {bool isCircle = false}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: isCircle
          ? BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
            )
          : null,
      child: IconButton(
        icon: Icon(icon),
        onPressed: function,
        color: isCircle ? Colors.white : Colors.grey,
      ),
    );
  }
}

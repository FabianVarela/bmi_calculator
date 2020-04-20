import 'package:bmi_calculator/ui/common/custom_clip_path.dart';
import 'package:bmi_calculator/ui/animation/interval_column_bottom_animation.dart';
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
              padding: EdgeInsets.fromLTRB(24, 50, 24, 120),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: IntervalColumnBottomAnimation(
                duration: Duration(milliseconds: 800),
                height: MediaQuery.of(context).size.height,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _setTitle(),
                  _setCardResult(),
                  _setTextResult(),
                  _setMessage(),
                  _setOptionIcons(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _setArcButton(),
          ),
        ],
      ),
    );
  }

  Widget _setTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 30),
      child: Text(
        'BMI final result',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _setCardResult() {
    return Card(
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
    );
  }

  Widget _setTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        'Overweight',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _setMessage() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              'BMI = 22.93 kg/m2',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              'BMI weight range for the height:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              '128.9 lbs - 174.2 lbs',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _setOptionIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _setIconButton(Icons.save, () => print('Save data')),
        _setIconButton(
          Icons.refresh,
          () => Navigator.pop(context),
          isCircle: true,
        ),
        _setIconButton(Icons.share, () => print('Share data')),
      ],
    );
  }

  Widget _setIconButton(IconData icon, Function function,
      {bool isCircle = false}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(5),
      decoration: isCircle
          ? BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(50),
            )
          : null,
      child: IconButton(
        onPressed: function,
        padding: EdgeInsets.zero,
        icon: Icon(
          icon,
          size: 30,
          color: isCircle ? Colors.white : Colors.blueGrey,
        ),
      ),
    );
  }

  Widget _setArcButton() {
    return Align(
      alignment: Alignment.center,
      child: FractionalTranslation(
        translation: Offset(0.0, 0.6),
        child: GestureDetector(
          onTap: () => print('My profile'),
          child: Container(
            width: 200,
            height: 200,
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Icon(
                Icons.account_circle,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

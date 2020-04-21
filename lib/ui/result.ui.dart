import 'package:bmi_calculator/ui/common/custom_clip_path.dart';
import 'package:bmi_calculator/ui/animation/interval_column_bottom_animation.dart';
import 'package:bmi_calculator/ui/utils/responsive.dart';
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
              padding: EdgeInsets.fromLTRB(
                Responsive.getInstance().setWidth(24),
                Responsive.getInstance().setHeight(10),
                Responsive.getInstance().setWidth(24),
                Responsive.getInstance().setHeight(90),
              ),
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
    return SafeArea(
      top: true,
      bottom: false,
      child: Text(
        'BMI final result',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Responsive.getInstance().setSp(40),
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _setCardResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 20,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Responsive.getInstance().setHeight(25),
          ),
          child: Text(
            '22.4',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Responsive.getInstance().setSp(90),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _setTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.getInstance().setHeight(15),
      ),
      child: Text(
        'Overweight',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Responsive.getInstance().setSp(35),
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _setMessage() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.getInstance().setHeight(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'BMI = 22.93 kg/m2',
            style: TextStyle(
              fontSize: Responsive.getInstance().setSp(20),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'BMI weight range for the height:',
            style: TextStyle(
              fontSize: Responsive.getInstance().setSp(18),
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            '128.9 lbs - 174.2 lbs',
            style: TextStyle(
              fontSize: Responsive.getInstance().setSp(18),
              fontWeight: FontWeight.w200,
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
      margin: EdgeInsets.symmetric(
        horizontal: Responsive.getInstance().setWidth(10),
      ),
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
            width: Responsive.getInstance().setWidth(200),
            height: Responsive.getInstance().setHeight(200),
            padding: EdgeInsets.all(25),
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

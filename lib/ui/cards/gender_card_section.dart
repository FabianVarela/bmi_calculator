import 'dart:math' as math;

import 'package:bmi_calculator/model/gender.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const double _defaultAngle = math.pi / 4;

const Map<String, double> _genderAngles = <String, double>{
  'Female': -_defaultAngle,
  'Other': 0.0,
  'Male': _defaultAngle,
};

class GenderCardSection extends StatefulWidget {
  GenderCardSection({@required this.onChangeGender});

  final Function(Gender gender) onChangeGender;

  @override
  _GenderCardSectionState createState() => _GenderCardSectionState();
}

class _GenderCardSectionState extends State<GenderCardSection>
    with SingleTickerProviderStateMixin {
  final List<Gender> _genderList = <Gender>[
    Gender('Female', 'assets/images/gender/female_icon.svg'),
    Gender('Other', 'assets/images/gender/other_icon.svg'),
    Gender('Male', 'assets/images/gender/male_icon.svg'),
  ];

  String _currentGender;

  AnimationController _controller;

  @override
  void initState() {
    _currentGender = 'Other';
    _controller = AnimationController(
      vsync: this,
      lowerBound: -_defaultAngle,
      upperBound: _defaultAngle,
      value: _genderAngles[_currentGender],
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Container(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(.6),
                  ),
                ),
                ArrowSelector(listenable: _controller),
              ],
            ),
            GenderIcon(gender: _genderList[0]),
            GenderIcon(gender: _genderList[1]),
            GenderIcon(gender: _genderList[2]),
            Positioned.fill(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: List<Widget>.generate(3, (int index) {
                  return GenderSelector(
                    gender: _genderList[index],
                    onGenderSelected: (Gender gender) {
                      setState(() => _currentGender = gender.name);
                      widget.onChangeGender(gender);

                      _controller.animateTo(
                        _genderAngles[gender.name],
                        duration: Duration(milliseconds: 150),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GenderIcon extends StatelessWidget {
  GenderIcon({@required this.gender});

  final Gender gender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 55),
      child: Transform.rotate(
        alignment: Alignment.bottomCenter,
        angle: _genderAngles[gender.name],
        child: Padding(
          padding: EdgeInsets.only(bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Transform.rotate(
                angle: -_genderAngles[gender.name],
                child: Padding(
                  padding: EdgeInsets.only(left: gender.isOther ? 8 : 0),
                  child: SvgPicture.asset(
                    gender.asset,
                    height: gender.isOther ? 24 : 18,
                    width: gender.isOther ? 24 : 18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8, top: 10),
                child: Container(
                  height: 10,
                  width: 2,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArrowSelector extends AnimatedWidget {
  ArrowSelector({@required this.listenable, this.arrowSize = 40})
      : super(listenable: listenable);

  final Listenable listenable;
  final double arrowSize;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    return Transform.rotate(
      angle: animation.value,
      child: Transform.translate(
        offset: Offset(0.0, arrowSize * -0.4),
        child: Transform.rotate(
          angle: -_defaultAngle,
          child: SvgPicture.asset(
            'assets/images/gender/arrow.svg',
            height: arrowSize,
            width: arrowSize,
          ),
        ),
      ),
    );
  }
}

class GenderSelector extends StatelessWidget {
  GenderSelector({@required this.gender, this.onGenderSelected});

  final Gender gender;
  final Function(Gender) onGenderSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onGenderSelected(gender),
      ),
    );
  }
}

import 'dart:math' as math;

import 'package:bmi_calculator/model/gender.dart';
import 'package:bmi_calculator/ui/utils/responsive.dart';
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
    super.initState();

    _currentGender = 'Other';
    _controller = AnimationController(
      vsync: this,
      lowerBound: -_defaultAngle,
      upperBound: _defaultAngle,
      value: _genderAngles[_currentGender],
    );

    Future<void>.delayed(
      Duration(milliseconds: 100),
      () => widget.onChangeGender(_genderList[1]),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Responsive.getInstance().setHeight(16),
      ),
      child: Container(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: Responsive.getInstance().setWidth(100),
                  height: Responsive.getInstance().setHeight(100),
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
    final Responsive responsive = Responsive.getInstance();
    final double heightAsset = responsive.setHeight(gender.isOther ? 24 : 18);
    final double widthAsset = responsive.setWidth(gender.isOther ? 24 : 18);

    return Padding(
      padding: EdgeInsets.only(bottom: responsive.setHeight(50)),
      child: Transform.rotate(
        alignment: Alignment.bottomCenter,
        angle: _genderAngles[gender.name],
        child: Padding(
          padding: EdgeInsets.only(bottom: responsive.setHeight(50)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Transform.rotate(
                angle: -_genderAngles[gender.name],
                child: Padding(
                  padding: EdgeInsets.only(
                      left: gender.isOther ? responsive.setWidth(10) : 0),
                  child: SvgPicture.asset(
                    gender.asset,
                    height: heightAsset,
                    width: widthAsset,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: responsive.setHeight(8),
                  top: responsive.setHeight(10),
                ),
                child: Container(
                  height: responsive.setHeight(10),
                  width: responsive.setWidth(2),
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

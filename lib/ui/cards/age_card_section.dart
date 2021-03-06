import 'package:bmi_calculator/model/gender.dart';
import 'package:bmi_calculator/ui/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AgeCardSection extends StatefulWidget {
  AgeCardSection({@required this.gender, @required this.onChangeAge});

  final Gender gender;
  final Function(int age) onChangeAge;

  @override
  _AgeCardSectionState createState() => _AgeCardSectionState();
}

class _AgeCardSectionState extends State<AgeCardSection>
    with SingleTickerProviderStateMixin {
  final FixedExtentScrollController _controller = FixedExtentScrollController();

  int _age;

  String _currentSeason;
  String _currentAssetImage;

  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _age = 2;
    _currentSeason = '';

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _setImage();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _setImage();

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        if (_currentAssetImage.isNotEmpty)
          FadeTransition(
            opacity: _animation,
            child: Opacity(
              opacity: .1,
              child: Center(
                child: SvgPicture.asset(
                  _currentAssetImage,
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * 0.22,
                ),
              ),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.arrow_right,
              size: 45,
              color: Colors.indigo,
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: ListWheelScrollView(
                  controller: _controller,
                  itemExtent: 30,
                  magnification: 1.5,
                  useMagnifier: true,
                  physics: FixedExtentScrollPhysics(),
                  offAxisFraction: -0.5,
                  children: List<Widget>.generate(91, (int index) {
                    final int finalValue = index + 2;

                    return Container(
                      padding: EdgeInsets.all(3),
                      decoration: finalValue == _age
                          ? BoxDecoration(
                              color: Colors.blueAccent,
                              shape: BoxShape.circle,
                            )
                          : null,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '$finalValue',
                          style: TextStyle(
                            fontSize: Responsive.getInstance().setSp(15),
                            color: finalValue == _age ? Colors.white : null,
                            fontWeight: finalValue == _age
                                ? FontWeight.w300
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  }),
                  onSelectedItemChanged: (int value) {
                    setState(() => _age = value + 2);
                    widget.onChangeAge(value + 2);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _setImage() {
    if (widget.gender != null) {
      String season;

      if (_age >= 2 && _age < 15) {
        season = 'child';
      } else if (_age >= 15 && _age < 30) {
        season = 'young';
      } else if (_age >= 30 && _age < 60) {
        season = 'adult';
      } else {
        season = 'old';
      }

      final String genderLowerCase = widget.gender.name.toLowerCase();

      if (_currentSeason != season) {
        _currentSeason = season;
        _animationController.reverse();

        Future<void>.delayed(Duration(milliseconds: 1000), () {
          setState(() => _currentAssetImage =
              'assets/images/age/$season\_$genderLowerCase.svg');
          _animationController.forward();
        });
      } else {
        _currentAssetImage = 'assets/images/age/$season\_$genderLowerCase.svg';
      }
    } else {
      _currentAssetImage = '';
    }
  }
}

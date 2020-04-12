import 'package:bmi_calculator/model/gender.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

    _age = 0;
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
      children: <Widget>[
        if (_currentAssetImage.isNotEmpty)
          FadeTransition(
            opacity: _animation,
            child: Opacity(
              opacity: .1,
              child: Center(
                child: Image.asset(
                  _currentAssetImage,
                  fit: BoxFit.contain,
                  width: 150,
                  height: 250,
                ),
              ),
            ),
          ),
        Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.arrow_right,
                  size: 45,
                  color: Colors.indigo,
                ),
                Expanded(
                  child: Container(
                    height: 180,
                    child: ListWheelScrollView(
                      controller: _controller,
                      itemExtent: 40,
                      magnification: 1.5,
                      useMagnifier: true,
                      physics: FixedExtentScrollPhysics(),
                      offAxisFraction: -0.4,
                      children: List<Widget>.generate(91, (int index) {
                        return Container(
                          padding: EdgeInsets.all(3),
                          decoration: index == _age
                              ? BoxDecoration(
                                  color: Colors.blueAccent,
                                  shape: BoxShape.circle,
                                )
                              : null,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '$index',
                              style: TextStyle(
                                fontSize: 15,
                                color: index == _age ? Colors.white : null,
                                fontWeight: index == _age
                                    ? FontWeight.w300
                                    : FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }),
                      onSelectedItemChanged: (int value) {
                        setState(() => _age = value);
                        widget.onChangeAge(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void _setImage() {
    if (widget.gender != null) {
      String season;

      if (_age >= 0 && _age < 15) {
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

        Future<void>.delayed(Duration(milliseconds: 200), () {
          setState(() => _currentAssetImage =
              'assets/images/age/$season\_$genderLowerCase.png');
          _animationController.forward();
        });
      } else {
        _currentAssetImage = 'assets/images/age/$season\_$genderLowerCase.png';
      }
    } else {
      _currentAssetImage = '';
    }
  }
}

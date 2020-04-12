import 'package:bmi_calculator/model/gender.dart';
import 'package:bmi_calculator/ui/cards/age_card_section.dart';
import 'package:bmi_calculator/ui/cards/gender_card_section.dart';
import 'package:bmi_calculator/ui/cards/height_card_section.dart';
import 'package:bmi_calculator/ui/common/custom_card.dart';
import 'package:bmi_calculator/ui/common/header_clip_path.dart';
import 'package:bmi_calculator/ui/common/profile_icon_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeBMI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomeBMI> with TickerProviderStateMixin {
  Gender _currentGender;
  int _currentAge;
  int _currentHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: HeaderClipPath(),
            child: Container(
              color: Colors.blueAccent,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 25),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _setHeader(),
                _setBody(),
                _setButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _setHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 50, bottom: 20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'BMI Calculator',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ProfileIconAnimation(durationSeconds: 1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _setBody() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: CustomCard(
                    title: 'Gender',
                    subtitle: 'Gender selected',
                    message: _currentGender?.name ?? 'No selected',
                    child: GenderCardSection(
                      onChangeGender: (Gender gender) {
                        setState(() => _currentGender = gender);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: CustomCard(
                    title: 'Age',
                    subtitle: 'Age selected',
                    message: '${_currentAge ?? 0} years',
                    child: AgeCardSection(
                      gender: _currentGender,
                      onChangeAge: (int age) {
                        setState(() => _currentAge = age);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: CustomCard(
                    title: 'Height',
                    subtitle: 'Height selected',
                    message: '${_currentHeight ?? 0} cm',
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                    child: LayoutBuilder(
                      builder: (_, BoxConstraints constraints) {
                        return HeightCardSection(
                          doubleHeight: constraints.maxHeight,
                          onChangeHeight: (int height) {
                            setState(() => _currentHeight = height);
                          },
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: CustomCard(
                    title: 'Weight',
                    child: Container(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _setButton() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: RaisedButton(
        onPressed: () {},
        color: Colors.indigo,
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          'Calculate',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

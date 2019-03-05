import 'package:flutter/material.dart';

class HomeBMI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomeBMI> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double inches = 0.0;
  double result = 0.0;

  void _calculateBMI() {
    setState(() {
      int age = int.parse(_ageController.text);
      double height = double.parse(_heightController.text);
      int weight = int.parse(_weightController.text);

      inches = height * 12;

      if ((_ageController.text.isNotEmpty || age > 0) &&
          (_heightController.text.isNotEmpty || inches > 0) &&
          (_weightController.text.isEmpty || weight > 0)) {
        result = weight / (inches * inches) * 703;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: Text("BMI"),
          centerTitle: true,
          backgroundColor: Colors.greenAccent),
      body: Container(
          alignment: Alignment.topCenter,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: <Widget>[
              Image.asset("images/bmilogo.png", height: 85, width: 75),
              Padding(padding: EdgeInsets.all(10)),
              Container(
                margin: EdgeInsets.all(3),
                height: 290,
                width: 290,
                color: Colors.grey.shade300,
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Age",
                          hintText: "e.g: 34",
                          icon: Icon(Icons.person)),
                    ),
                    TextField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Height in feet",
                          hintText: "e.g: 6.5",
                          icon: Icon(Icons.insert_chart)),
                    ),
                    TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Weight in lbs",
                          hintText: "e.g: 180",
                          icon: Icon(Icons.line_weight)),
                    ),
                    Padding(padding: EdgeInsets.all(11)),
                    Container(
                        alignment: Alignment.center,
                        child: RaisedButton(
                          onPressed: () {},
                          color: Colors.greenAccent,
                          child: Text("Calculate"),
                          textColor: Colors.white,
                        ))
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "BMI",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        fontSize: 20),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Text(
                    "Overweight",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        fontSize: 20),
                  )
                ],
              )
            ],
          )),
    );
  }
}

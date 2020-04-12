import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WeightCardSection extends StatefulWidget {
  WeightCardSection({@required this.onChangeWeight});

  final Function(int weight) onChangeWeight;

  @override
  _WeightCardSectionState createState() => _WeightCardSectionState();
}

class _WeightCardSectionState extends State<WeightCardSection> {
  int _currentWeight;

  @override
  void initState() {
    super.initState();
    _currentWeight = _currentWeight ?? 70;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: LayoutBuilder(
              builder: (_, BoxConstraints constraints) => WeightSlider(
                weightValue: _currentWeight,
                width: constraints.maxWidth,
                onChanged: (int weight) {
                  setState(() => _currentWeight = weight);
                  widget.onChangeWeight(_currentWeight);
                },
              ),
            ),
          ),
          Icon(
            Icons.arrow_drop_up,
            size: 25,
            color: Colors.indigo,
          ),
        ],
      ),
    );
  }
}

class WeightSlider extends StatelessWidget {
  WeightSlider({
    @required this.width,
    @required this.onChanged,
    @required this.weightValue,
    this.minWeight = 30,
    this.maxWeight = 140,
  }) : scrollController = ScrollController(
          initialScrollOffset: (weightValue - minWeight) * width / 3,
        );

  final int weightValue;
  final Function(int weight) onChanged;

  final double width;
  final int minWeight;
  final int maxWeight;

  final ScrollController scrollController;

  double get itemExtent => width / 3;

  @override
  Widget build(BuildContext context) {
    final int itemCount = (maxWeight - minWeight) + 3;

    return NotificationListener<Notification>(
      onNotification: _onNotification,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemExtent: itemExtent,
        itemCount: itemCount,
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, int index) {
          final int itemValue = _indexValue(index);
          final bool isExtra = index == 0 || index == itemCount - 1;

          return isExtra
              ? Container()
              : Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '$itemValue',
                      style: TextStyle(
                        fontSize: itemValue == weightValue ? 28 : 14,
                        color: itemValue == weightValue
                            ? Colors.blueGrey
                            : Colors.black,
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }

  int _indexValue(int index) => minWeight + (index - 1);

  int _offsetToMiddleIndex(double offset) => (offset + width / 2) ~/ itemExtent;

  int _offsetToMiddleValue(double offset) {
    int middleValue = _indexValue(_offsetToMiddleIndex(offset));
    middleValue = max(minWeight, min(maxWeight, middleValue));
    return middleValue;
  }

  bool _isUserStopScroll(Notification notification) =>
      notification is UserScrollNotification &&
      notification.direction == ScrollDirection.idle &&
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      scrollController.position.activity is! HoldScrollActivity;

  void _animateTo(int valueSelected, {int duration = 200}) {
    final double target = (valueSelected - minWeight) * itemExtent;
    scrollController.animateTo(
      target,
      duration: Duration(milliseconds: duration),
      curve: Curves.decelerate,
    );
  }

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      final int middleValue = _offsetToMiddleValue(notification.metrics.pixels);

      if (_isUserStopScroll(notification)) {
        _animateTo(middleValue);
      }

      if (middleValue != weightValue) {
        onChanged(middleValue); //update selection
      }
    }

    return true;
  }
}

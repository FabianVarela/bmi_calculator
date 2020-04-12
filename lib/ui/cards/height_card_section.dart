import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeightCardSection extends StatefulWidget {
  HeightCardSection({
    @required this.doubleHeight,
    @required this.onChangeHeight,
    this.minHeight = 140,
    this.maxHeight = 200,
  });

  final Function(int height) onChangeHeight;
  final int minHeight;
  final int maxHeight;
  final double doubleHeight;

  int get total => maxHeight - minHeight;

  @override
  _HeightCardSectionState createState() => _HeightCardSectionState();
}

class _HeightCardSectionState extends State<HeightCardSection> {
  int _currentHeight;

  double get _drawHeight => widget.doubleHeight - (16 + 7 + 14);

  double get _pixelsHeight => _drawHeight / widget.total;

  double get _position {
    final double halfLabel = 14 / 2;
    final int units = _currentHeight - widget.minHeight;
    return halfLabel + units * _pixelsHeight;
  }

  double _startDragYOffset;
  int _startDragHeight;

  @override
  void initState() {
    super.initState();
    _currentHeight = _currentHeight ?? 170;

    Future<void>.delayed(Duration(milliseconds: 100),
        () => widget.onChangeHeight(_currentHeight));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: _onTapHeight,
      onVerticalDragStart: _onDragStartHeight,
      onVerticalDragUpdate: _onDragUpdateHeight,
      child: Stack(
        children: <Widget>[
          _setPerson(),
          _setSlider(),
          _setLabels(),
        ],
      ),
    );
  }

  Widget _setLabels() {
    return Align(
      alignment: Alignment.centerRight,
      child: IgnorePointer(
        child: Padding(
          padding: EdgeInsets.only(right: 12, bottom: 16, top: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List<Widget>.generate(widget.total ~/ 5 + 1, (int index) {
              return Text(
                '${widget.maxHeight - 5 * index}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blueGrey,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _setSlider() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: _position,
      child: IgnorePointer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.unfold_more,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: List<Widget>.generate(40, (int index) {
                      return Expanded(
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: index.isEven ? Colors.blueAccent : null,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _setPerson() {
    final double personHeight = _position + 16;

    return Align(
      alignment: Alignment.bottomCenter,
      child: SvgPicture.asset(
        'assets/images/height/person.svg',
        color: Colors.black,
        height: personHeight,
        width: personHeight / 3,
      ),
    );
  }

  void _onTapHeight(TapDownDetails details) {
    final int height = _offsetHeight(details.globalPosition);
    setState(() => _currentHeight = _normalizeHeight(height));
    widget.onChangeHeight(_currentHeight);
  }

  void _onDragStartHeight(DragStartDetails dragStartDetails) {
    final int newHeight = _offsetHeight(dragStartDetails.globalPosition);
    setState(() {
      _startDragYOffset = dragStartDetails.globalPosition.dy;
      _startDragHeight = newHeight;
      _currentHeight = newHeight;
    });
    widget.onChangeHeight(_currentHeight);
  }

  void _onDragUpdateHeight(DragUpdateDetails dragUpdateDetails) {
    final double currentYOffset = dragUpdateDetails.globalPosition.dy;
    final double verticalDifference = _startDragYOffset - currentYOffset;
    final int diffHeight = verticalDifference ~/ _pixelsHeight;
    setState(() {
      _currentHeight = _normalizeHeight(_startDragHeight + diffHeight);
    });
    widget.onChangeHeight(_currentHeight);
  }

  int _normalizeHeight(int height) =>
      max(widget.minHeight, min(widget.maxHeight, height));

  int _offsetHeight(Offset offset) {
    final RenderBox renderBox = context.findRenderObject();
    final Offset position = renderBox.globalToLocal(offset);

    double dy = position.dy;
    dy = dy - 26 - 14 / 2;

    return widget.maxHeight - (dy ~/ _pixelsHeight);
  }
}

import 'package:flutter/material.dart';

class DoubleColorLayout extends StatelessWidget {
  const DoubleColorLayout(
      {Key? key,
      required this.topColor,
      this.bottomColor,
      required this.topChild,
      required this.bottomChild,
      this.heightPercentage = 0.5})
      : super(key: key);

  final Color topColor;
  final Color? bottomColor;
  final Widget topChild;
  final Widget bottomChild;
  final double heightPercentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          color: bottomColor,
        ),
        Container(
          color: topColor,
          height: MediaQuery.of(context).size.height * heightPercentage,
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: topChild,
            ),
          ),
        ),
        Positioned(
          top: (MediaQuery.of(context).size.height * heightPercentage) - 50,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).size.height * heightPercentage + 50),
          child: bottomChild,
        ),
      ],
    );
  }
}

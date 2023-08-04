import 'package:flutter/material.dart';

class ClickableCard extends StatelessWidget {
  const ClickableCard(
      {Key? key,
      required this.width,
      required this.height,
      required this.child,
      required this.onTap})
      : super(key: key);
  final double width;
  final double height;
  final Widget child;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: width,
          height: height,
          child: child,
        ),
      ),
    );
  }
}

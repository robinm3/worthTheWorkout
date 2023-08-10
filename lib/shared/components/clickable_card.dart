import 'package:flutter/material.dart';

class ClickableCard extends StatelessWidget {
  const ClickableCard(
      {Key? key,
      this.width = 100,
      this.height = 120,
      required this.child,
      required this.onTap,
      this.isSelected = false})
      : super(key: key);
  final double width;
  final double height;
  final Widget child;
  final Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Theme.of(context).colorScheme.primary : null,
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

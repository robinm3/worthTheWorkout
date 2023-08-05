import 'package:flutter/material.dart';

class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress(
      {super.key,
      required this.timeLeft,
      required this.progress,
      this.height = 80});
  final int timeLeft;
  final double progress;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(children: [
        const Center(
            child: CircularProgressIndicator(
          value: 1,
          color: Colors.grey,
          strokeWidth: 10,
        )),
        Center(
            child: CircularProgressIndicator(
          value: progress,
        )),
        Center(child: Text('$timeLeft')),
      ]),
    );
  }
}

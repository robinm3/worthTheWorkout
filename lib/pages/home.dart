import 'package:flutter/material.dart';
import 'package:workout/pages/workouts_for_muscle.dart';
import 'package:workout/shared/components/clickable_card.dart';

import '../services/workout_service.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final WorkoutService workoutService = WorkoutService();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const pages = [
    {'label': 'Upper Body', 'icon': '💪'},
    {'label': 'Lower Body', 'icon': '🦵'},
    {'label': 'Core', 'icon': '🦺'},
    {'label': 'Other', 'icon': '🏋️'},
  ];

  void _onPageSelected(String page) async {
    widget.workoutService
        .getWorkoutNamesForMuscle(page.replaceAll(" ", "").toLowerCase())
        .then((value) {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WorkoutsForMusclePage(
                  muscle: page,
                  workouts: value,
                  workoutService: widget.workoutService)),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.primary,
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text("Let's get started!", style: style),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                for (final page in pages)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ClickableCard(
                      onTap: () => _onPageSelected(page['label']!),
                      width: 100,
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(page['icon']!, style: style),
                          Text(page['label']!),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:workout/pages/workout_info.dart';
import 'package:workout/shared/components/clickable_card.dart';

import '../services/workout_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  final WorkoutService workoutService = const WorkoutService();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const pages = [
    {'label': 'Upper Body', 'icon': '💪'},
    {'label': 'Lower Body', 'icon': '🦵'},
    {'label': 'Core', 'icon': '🦺'}
  ];

  void _onPageSelected(String page) {
    setState(() {
      var defaultWorkout = getWorkoutForMuscle(page);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                WorkoutInfoPage(title: page, workout: defaultWorkout)),
      );
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

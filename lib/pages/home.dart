import 'package:flutter/material.dart';
import 'package:workout/pages/workouts/workouts.dart';
import 'package:workout/services/infrastructure/workout/firestore_workout_repo.dart';

import '../services/types/workout_types.dart';
import '../services/workout_service.dart';
import '../shared/layouts/double_color_layout.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  final WorkoutService workoutService = WorkoutService(FirestoreWorkoutRepo());

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BaseWorkout> workouts = [];

  @override
  Widget build(BuildContext context) {
    if (workouts.isEmpty) {
      widget.workoutService.getWorkouts().then((value) {
        setState(() {
          workouts = value;
        });
      });
    }

    final theme = Theme.of(context);

    return Scaffold(
      body: DoubleColorLayout(
        topColor: theme.colorScheme.primary,
        topChild: Text(
          'Let\'s get started!',
          style: theme.primaryTextTheme.displaySmall,
        ),
        bottomChild: Wrap(
          alignment: WrapAlignment.center,
          children: [
            WorkoutsList(
                workouts: workouts, workoutService: widget.workoutService),
          ],
        ),
      ),
    );
  }
}

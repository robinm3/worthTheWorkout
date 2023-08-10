import 'package:flutter/material.dart';
import 'package:workout/pages/workouts/workout_info.dart';
import 'package:workout/services/types/workout_types.dart';

import '../../services/workout_service.dart';
import '../../shared/components/clickable_card.dart';

const filters = [
  {'label': 'Upper Body', 'icon': '💪'},
  {'label': 'Lower Body', 'icon': '🦵'},
  {'label': 'Core', 'icon': '🦺'},
  {'label': 'Other', 'icon': '🏋️'},
];

class WorkoutsList extends StatefulWidget {
  const WorkoutsList(
      {Key? key, required this.workouts, required this.workoutService})
      : super(key: key);

  final List<BaseWorkout> workouts;
  final WorkoutService workoutService;

  @override
  State<WorkoutsList> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsList> {
  void onBackButtonPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _onWorkoutSelected(BaseWorkout baseWorkout) async {
    widget.workoutService.getWorkout(baseWorkout.id).then((value) {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  WorkoutInfoPage(title: baseWorkout.name, workout: value)),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Wrap(alignment: WrapAlignment.center, children: [
            for (final workout in widget.workouts)
              ClickableCard(
                width: 100,
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(workout.name),
                  ],
                ),
                onTap: () {
                  _onWorkoutSelected(workout);
                },
              ),
          ]),
        ),
      );
}

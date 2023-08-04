import 'package:flutter/material.dart';
import 'package:workout/pages/workout_info.dart';

import '../services/workout_service.dart';
import '../shared/components/clickable_card.dart';

class WorkoutsForMusclePage extends StatefulWidget {
  const WorkoutsForMusclePage(
      {Key? key,
      required this.muscle,
      required this.workouts,
      required this.workoutService})
      : super(key: key);

  final String muscle;
  final List<String> workouts;
  final WorkoutService workoutService;

  @override
  State<WorkoutsForMusclePage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsForMusclePage> {
  void onBackButtonPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _onWorkoutSelected(String workoutLabel) async {
    int index = widget.workouts.indexOf(workoutLabel);
    widget.workoutService
        .getWorkoutForMuscle(
            widget.muscle.replaceAll(" ", "").toLowerCase(), index)
        .then((value) {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  WorkoutInfoPage(title: workoutLabel, workout: value)),
        );
      });
    });
  }

  static const titleStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => onBackButtonPressed(context),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(widget.muscle, style: titleStyle),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 120,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      for (final workout in widget.workouts)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ClickableCard(
                            width: 100,
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(workout),
                              ],
                            ),
                            onTap: () {
                              _onWorkoutSelected(workout);
                            },
                          ),
                        )
                    ]),
              ),
            ),
          ],
        ),
      );
}

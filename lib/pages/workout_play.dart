import 'dart:async';

import 'package:flutter/material.dart';

import '../types/workout_types.dart';

class WorkoutPlay extends StatefulWidget {
  const WorkoutPlay({super.key, required this.workout});
  final Workout workout;

  @override
  State<WorkoutPlay> createState() => _WorkoutPlayState();
}

class _WorkoutPlayState extends State<WorkoutPlay> {
  int currentExerciseIndex = 0;
  Exercice? currentExercise;
  int currentRepCount = 0;
  int currentSetCount = 0;
  bool isResting = false;
  bool isFinished = false;
  bool isPaused = false;
  Timer? timer;
  int completedRepTime = 0;
  int completedSetTime = 0;
  int completedRestTime = 0;

  @override
  void initState() {
    super.initState();
    currentExercise = widget.workout.exercices[0];
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isPaused) {
        return;
      }
      setState(() {
        onAddSecond();
      });
    });
  }

  void onAddSecond() {
    if (isResting) {
      completedRestTime++;
      if (completedRestTime >= currentExercise!.restTime) {
        isResting = false;
        completedRestTime = 0;
        completedSetTime = 0;
        if (currentSetCount >= currentExercise!.setCount) {
          completedRepTime = 0;
          _onNextExercise();
          return;
        }
        _onNextSet();
      }
      return;
    }

    completedRepTime++;
    completedSetTime++;
    if (completedRepTime >= currentExercise!.timeForRep) {
      _onNextRep();
    }
  }

  void _onNextExercise() {
    if (currentExerciseIndex == widget.workout.exercices.length - 1) {
      setState(() {
        timer!.cancel();
        isFinished = true;
      });
      return;
    }
    setState(() {
      currentExerciseIndex++;
      currentExercise = widget.workout.exercices[currentExerciseIndex];
      currentRepCount = 0;
      currentSetCount = 0;
    });
  }

  void _onNextSet() {
    setState(() {
      currentSetCount++;
      currentRepCount = 0;
    });
  }

  void _onNextRep() {
    completedRepTime = 0;
    if (currentRepCount ==
        widget.workout.exercices[currentExerciseIndex].repCount) {
      setState(() {
        isResting = true;
      });
      return;
    }
    setState(() {
      currentRepCount++;
    });
  }

  double getProgressValue() {
    if (isResting) {
      return (completedRestTime / currentExercise!.restTime);
    }
    return (completedSetTime /
        (currentExercise!.repCount * currentExercise!.timeForRep));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.workout.name),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Column(children: [
            Text(currentExercise!.name,
                style: Theme.of(context).textTheme.displayMedium),
            SizedBox(
              width: 400,
              height: 400,
              child: Image.network(currentExercise!.imageLink),
            ),
            if (isResting)
              Text(
                'Rest',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            if (!isResting)
              Text(
                '${currentExercise!.repCount} reps',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            CircularProgressIndicator(
              value: getProgressValue(),
              semanticsValue: '$completedSetTime',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Sets left: ${currentExercise!.setCount - currentSetCount}')
              ],
            ),
            if (isFinished) const Text('Finished!'),
          ]),
        ));
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared/components/custom_circular_progress.dart';
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
  int completedWorkoutTime = 0;
  int completedRepTime = 0;
  int completedRestTime = 0;

  @override
  void initState() {
    super.initState();
    currentExercise = widget.workout.exercices[0];
    if (exerciceNeedsTimer()) {
      setState(() {
        isPaused = true;
      });
    }
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        onAddSecond();
      });
    });
  }

  void onAddSecond() {
    completedWorkoutTime++;
    if (!isResting && isPaused) {
      return;
    }
    if (isResting) {
      completedRestTime++;
      if (completedRestTime >= currentExercise!.restTime) {
        SystemSound.play(SystemSoundType.alert);
        isResting = false;
        completedRestTime = 0;
        if (currentSetCount >= currentExercise!.setCount) {
          completedRepTime = 0;
          return;
        }
      }
      return;
    }
    completedRepTime++;

    if (exerciceNeedsTimer() &&
        completedRepTime >= currentExercise!.timeForRep) {
      isResting = true;
    }
  }

  void _onNextExercise() {
    if (currentExerciseIndex >= widget.workout.exercices.length - 1) {
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
      isResting = false;
      completedRepTime = 0;
      completedRestTime = 0;
      if (exerciceNeedsTimer()) {
        isPaused = true;
      }
    });
  }

  void _onNextSet() {
    setState(() {
      currentSetCount++;
      currentRepCount = 0;
    });
    if (currentSetCount >= currentExercise!.setCount) {
      setState(() {
        completedRepTime = 0;
      });
      _onNextExercise();
      return;
    }
  }

  bool exerciceNeedsTimer() {
    return currentExercise!.repCount == 1;
  }

  double getProgressValue() {
    if (isResting) {
      return (completedRestTime / currentExercise!.restTime);
    }
    return (completedRepTime / currentExercise!.timeForRep);
  }

  int getTimeLeft() {
    if (isResting) {
      return currentExercise!.restTime - completedRestTime;
    }
    return currentExercise!.timeForRep - completedRepTime;
  }

  String getNextExerciceButtonText() {
    if (!isFinished) {
      return "Skip";
    }
    return "Finished";
  }

  String getMainButtonText() {
    if (isFinished) {
      return "Finished";
    }
    if (isPaused) {
      return "Start";
    }
    if (isResting) {
      return "Skip rest";
    }
    if (!exerciceNeedsTimer()) {
      return '${currentExercise!.repCount} reps done';
    }
    return "Pause";
  }

  void _onEndSet() {
    if (isFinished) {
      Navigator.pop(context);
      return;
    }
    if (isPaused) {
      setState(() {
        isPaused = false;
      });
      return;
    }
    if (!isResting) {
      _onNextSet();
      if (currentExercise!.setCount - currentSetCount > 0) {
        setState(() {
          isResting = true;
        });
      }
    } else {
      setState(() {
        isResting = false;
        completedRestTime = 0;
      });
    }
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
          child: Wrap(alignment: WrapAlignment.center, children: [
            SizedBox(
              width: 400,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(currentExercise!.name,
                            style: Theme.of(context).textTheme.headlineSmall),
                        TextButton.icon(
                            label: Text(getNextExerciceButtonText(),
                                style: const TextStyle(fontSize: 20)),
                            onPressed: () {
                              if (!isFinished) {
                                completedRestTime = 0;
                                isResting = false;
                                _onNextExercise();
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            icon: const Icon(Icons.skip_next)),
                      ],
                    ),
                    Image.network(currentExercise!.imageLink),
                  ]),
            ),
            SizedBox(
                width: 300,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isResting)
                        Column(
                          children: [
                            Text(
                              'Rest',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            CustomCircularProgress(
                              progress: getProgressValue(),
                              timeLeft: getTimeLeft(),
                            ),
                          ],
                        ),
                      if (!isResting && !isFinished && exerciceNeedsTimer())
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (completedRepTime > 0)
                              CustomCircularProgress(
                                progress: getProgressValue(),
                                timeLeft: getTimeLeft(),
                              ),
                            if (!isPaused)
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPaused = true;
                                    });
                                  },
                                  icon: const Icon(Icons.pause)),
                          ],
                        ),
                      Center(
                        child: Text(
                            'Sets left: ${currentExercise!.setCount - currentSetCount}'),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton.extended(
                              onPressed: () {
                                _onEndSet();
                              },
                              label: Text(getMainButtonText(),
                                  style: const TextStyle(fontSize: 20)),
                            ),
                          ]),
                    ]))
          ]),
        ));
  }
}

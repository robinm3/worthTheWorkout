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
  bool isPaused = true;
  Timer? timer;
  int completedWorkoutTime = 0;
  int completedRepTime = 0;
  int completedRestTime = 0;

  @override
  void initState() {
    super.initState();
    currentExercise = widget.workout.exercices[0];
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
        isResting = false;
        completedRestTime = 0;
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
    });
  }

  void _onNextSet() {
    setState(() {
      currentSetCount++;
      currentRepCount = 0;
    });
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

  String getButtonText() {
    if (!isFinished) {
      return "Skip";
    }
    return "Finished";
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
              Column(
                children: [
                  Text(
                    'Rest',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  CustomCircularProgress(
                    progress: getProgressValue(),
                    timeLeft: getTimeLeft(),
                  ),
                ],
              ),
            if (!isResting && !exerciceNeedsTimer())
              Text(
                '${currentExercise!.repCount} reps',
                style: Theme.of(context).textTheme.displaySmall,
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
                  if (isPaused)
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isPaused = false;
                          });
                        },
                        icon: const Icon(Icons.play_arrow)),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Sets left: ${currentExercise!.setCount - currentSetCount}'),
                if ((currentExercise!.setCount - currentSetCount) > 0)
                  IconButton(
                      onPressed: () {
                        isResting = true;
                        _onNextSet();
                      },
                      icon: const Icon(Icons.skip_next)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: FloatingActionButton.extended(
                onPressed: () {
                  if (!isFinished) {
                    _onNextExercise();
                  } else {
                    Navigator.pop(context);
                  }
                },
                label:
                    Text(getButtonText(), style: const TextStyle(fontSize: 20)),
              ),
            ),
          ]),
        ));
  }
}

class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress(
      {super.key, required this.timeLeft, required this.progress});
  final int timeLeft;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(children: [
        const Center(
            child: CircularProgressIndicator(
          value: 1,
          color: Colors.grey,
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

import 'package:flutter/material.dart';
import 'package:workout/services/exercice_service.dart';
import 'package:workout/services/infrastructure/exercice/firestore_exercice_repo.dart';
import 'package:workout/services/infrastructure/workout/firestore_workout_repo.dart';
import 'package:workout/shared/components/questionTypes/choose_question.dart';
import 'package:workout/shared/components/questionTypes/text_question.dart';
import 'package:workout/services/types/workout_types.dart';

import '../../services/workout_service.dart';
import '../../shared/components/question_page.dart';

class WorkoutCreation extends StatefulWidget {
  WorkoutCreation({Key? key}) : super(key: key);

  final ExerciceService exerciceService =
      ExerciceService(FirestoreExerciceRepo());
  final WorkoutService workoutService = WorkoutService(FirestoreWorkoutRepo());

  @override
  WorkoutCreationState createState() => WorkoutCreationState();
}

class WorkoutCreationState extends State<WorkoutCreation> {
  String name = "";
  String trainingType = "";
  List<Exercice> possibleExercises = [];
  List<String> selectedExercises = [];

  @override
  void initState() {
    super.initState();
    widget.exerciceService.getExercices().then((value) {
      setState(() {
        possibleExercises = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: QuestionPage(
          onSubmit: () {
            widget.workoutService
                .createWorkout(trainingType, name, selectedExercises)
                .then((value) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Workout $name created'),
                duration: const Duration(seconds: 1),
              ));
              Navigator.pop(context);
            });
          },
          questions: [
            ChooseQuestion(
                question: "What exercises do you want to do?",
                subtitle: "You can select one more than once",
                multipleAnswers: true,
                canHaveSameAnswer: true,
                possibleAnswers: possibleExercises
                    .map((exercice) => PossibleAnswer(
                        label: exercice.name,
                        value: exercice.id,
                        icon: SizedBox(
                            width: 50,
                            height: 60,
                            child: Image.network(exercice.imageLink))))
                    .toList(),
                onChange: (value) {
                  selectedExercises = value;
                }),
            TextQuestion(
                question: "What is the name of your workout?",
                onChange: (value) {
                  name = value;
                }),
            ChooseQuestion(
                question: "What is your workout training?",
                possibleAnswers: [
                  PossibleAnswer(
                      label: "Upper body",
                      value: "upperbody",
                      icon: Text('💪',
                          style: Theme.of(context).textTheme.displayMedium)),
                  PossibleAnswer(
                      label: "Lower body",
                      value: "lowerbody",
                      icon: Text('🦵',
                          style: Theme.of(context).textTheme.displayMedium)),
                  PossibleAnswer(
                      label: "Core",
                      value: "core",
                      icon: Text('🦺',
                          style: Theme.of(context).textTheme.displayMedium)),
                  PossibleAnswer(
                      label: "Other",
                      value: "other",
                      icon: Text('🏋️',
                          style: Theme.of(context).textTheme.displayMedium)),
                ],
                onChange: (value) {
                  trainingType = value;
                }),
          ]),
    );
  }
}

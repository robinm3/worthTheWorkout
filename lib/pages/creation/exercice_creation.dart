import 'package:flutter/material.dart';
import 'package:workout/services/exercice_service.dart';
import 'package:workout/services/infrastructure/exercice/firestore_exercice_repo.dart';
import 'package:workout/shared/components/questionTypes/choose_question.dart';
import 'package:workout/shared/components/questionTypes/number_question.dart';
import 'package:workout/shared/components/questionTypes/text_question.dart';
import 'package:workout/shared/components/question_page.dart';

class ExerciceCreation extends StatefulWidget {
  ExerciceCreation({Key? key}) : super(key: key);

  final ExerciceService exerciceCreationService =
      ExerciceService(FirestoreExerciceRepo());

  @override
  ExerciceCreationState createState() => ExerciceCreationState();
}

class ExerciceCreationState extends State<ExerciceCreation> {
  String image = "";
  String name = "";
  String repType = "";
  int sets = 0;
  int restTime = 0;
  int time = 0;

  void _onCreateExercice() {
    int time = 0;
    widget.exerciceCreationService
        .createExercice(image, name, repType, sets, restTime, time)
        .then((value) => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Exercice $name created'),
                duration: const Duration(seconds: 1),
              )),
              Navigator.pop(context)
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).highlightColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Create Exercice",
            style: Theme.of(context).primaryTextTheme.headlineMedium),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: QuestionPage(
        onSubmit: _onCreateExercice,
        questions: [
          TextQuestion(
              question: "What is the image link of the exercice?",
              hint: "https://www.example.com/image.png",
              onChange: (value) {
                image = value;
              }),
          TextQuestion(
              question: "What is the name of the exercice?",
              hint: "Pushups",
              onChange: (value) {
                name = value;
              }),
          ChooseQuestion(
              question: "What is the rep type of the exercice?",
              possibleAnswers: [
                PossibleAnswer(
                    label: "Default",
                    value: "defaultRep",
                    icon: const Icon(Icons.fitness_center)),
                PossibleAnswer(
                    label: "Time",
                    value: "time",
                    icon: const Icon(Icons.timer)),
                PossibleAnswer(
                    label: "Twice the default reps",
                    value: "doubleRep",
                    icon: const Icon(Icons.double_arrow)),
              ],
              onChange: (value) {
                repType = value;
              }),
          if (repType == "time")
            NumberQuestion(
                question: "How long should the exercice be (in seconds)?",
                onChange: (value) {
                  time = value;
                }),
          NumberQuestion(
              question: "How many sets should be done?",
              hint: "3",
              onChange: (value) {
                sets = value;
              }),
          NumberQuestion(
              question: "How long should the rest be (in seconds)?",
              hint: "60",
              onChange: (value) {
                restTime = value;
              }),
        ],
      ),
    );
  }
}

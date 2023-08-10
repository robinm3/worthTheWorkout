import 'package:flutter/material.dart';
import 'package:workout/shared/components/questionTypes/question.dart';
import 'package:workout/shared/layouts/double_color_layout.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage(
      {Key? key, required this.questions, required this.onSubmit})
      : super(key: key);

  final List<Question> questions;
  final Function() onSubmit;

  @override
  State<QuestionPage> createState() => _QuestionComponentState();
}

class _QuestionComponentState extends State<QuestionPage> {
  bool get currentQuestionIsValid {
    return widget.questions[index].isValid;
  }

  void triggerChange() {
    setState(() {});
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleColorLayout(
          topColor: Theme.of(context).colorScheme.primary,
          topChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.questions[index].question,
                style: Theme.of(context).primaryTextTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              if (widget.questions[index].subtitle != null)
                Text(
                  widget.questions[index].subtitle!,
                  style: Theme.of(context).primaryTextTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
            ],
          ),
          heightPercentage: 0.4,
          bottomChild: Stack(
            children: [
              Column(
                children: [
                  for (Question question in widget.questions)
                    Visibility(
                      child: question.build(context, triggerChange),
                      maintainState: true,
                      visible: widget.questions.indexOf(question) == index,
                    ),
                ],
              ),
              Positioned(
                bottom: 0,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (index > 0)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            index--;
                          });
                        },
                        child: Text("Back"),
                      ),
                    if (index < widget.questions.length - 1 &&
                        currentQuestionIsValid)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            index++;
                          });
                        },
                        child: Text("Next"),
                      ),
                    if (index == widget.questions.length - 1 &&
                        currentQuestionIsValid)
                      TextButton(
                        onPressed: () {
                          widget.onSubmit();
                        },
                        child: Text("Finish"),
                      ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

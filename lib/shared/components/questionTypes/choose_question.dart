import 'package:flutter/material.dart';
import 'package:workout/shared/components/clickable_card.dart';
import 'package:workout/shared/components/questionTypes/question.dart';

class ChooseQuestion extends Question {
  ChooseQuestion({
    required String question,
    required this.possibleAnswers,
    required Function onChange,
    this.multipleAnswers = false,
    this.canHaveSameAnswer = false,
    subtitle,
  }) : super(
          question: question,
          onChange: onChange,
          subtitle: subtitle,
        );

  final List<PossibleAnswer> possibleAnswers;
  final bool multipleAnswers;
  final bool canHaveSameAnswer;

  @override
  bool get isValid {
    if (multipleAnswers) {
      return value is List<dynamic> && value.isNotEmpty;
    }
    return value is String && value.isNotEmpty;
  }

  @override
  String? get error {
    if (isValid) {
      return null;
    }
    return 'Please select something';
  }

  bool isSelected(PossibleAnswer answer) {
    if (multipleAnswers) {
      return value != null && value.contains(answer.value);
    }
    return value == answer.value;
  }

  String getAnswerWithNumbers(PossibleAnswer answer) {
    if (!isValid || !multipleAnswers) {
      return answer.label;
    }
    if (canHaveSameAnswer) {
      List<int> indexes = [];
      for (int i = 0; i < value.length; i++) {
        if (value[i] == answer.value) {
          indexes.add(i);
        }
      }
      return '${answer.label} ${indexes.map((index) => index + 1).join(', ')}';
    }
    return '${answer.label} ${value.indexOf(answer.value) + 1}';
  }

  @override
  build(BuildContext context, Function triggerChange) {
    return SizedBox(
      height:
          MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
              ? MediaQuery.of(context).size.height * 0.5
              : MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: possibleAnswers
                  .map((answer) => ClickableCard(
                        isSelected: isSelected(answer),
                        onTap: () {
                          if (multipleAnswers) {
                            value ??= List<String>.empty(growable: true);
                            if (value.contains(answer.value) &&
                                !canHaveSameAnswer) {
                              value.remove(answer.value);
                            } else {
                              value.add(answer.value);
                            }
                          } else {
                            value = answer.value;
                          }
                          onChange(value);
                          triggerChange();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            answer.icon ?? Container(),
                            Text(
                              isSelected(answer)
                                  ? getAnswerWithNumbers(answer)
                                  : answer.label,
                              style: isSelected(answer)
                                  ? Theme.of(context)
                                      .primaryTextTheme
                                      .bodyMedium
                                  : null,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
          if (canHaveSameAnswer && value != null && value.isNotEmpty)
            Positioned(
              bottom: 0,
              child: FloatingActionButton(
                onPressed: () {
                  // remove last value
                  value.removeLast();
                  onChange(value);
                  triggerChange();
                },
                child: Icon(Icons.undo),
              ),
            ),
        ],
      ),
    );
  }
}

class PossibleAnswer {
  PossibleAnswer({
    required this.label,
    required this.value,
    this.icon,
  });

  final String label;
  final String value;
  final Widget? icon;
  final bool isNotEmpty = true;
}

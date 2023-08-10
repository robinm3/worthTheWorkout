import 'package:flutter/material.dart';

import 'question.dart';

class TextQuestion extends Question {
  TextQuestion({
    required String question,
    required Function onChange,
    this.hint = 'Input here',
    subtitle,
  }) : super(
          question: question,
          onChange: onChange,
          subtitle: subtitle,
        );

  final String hint;
  bool touched = false;

  @override
  bool get isValid {
    return value is String && !value.isEmpty;
  }

  @override
  String? get error {
    if (isValid || !touched) {
      return null;
    }
    return 'Please enter some text';
  }

  void handleChange(String value) {
    onChange(value);
  }

  @override
  build(BuildContext context, Function triggerChange) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              errorText: error,
              hintText: hint,
            ),
            onChanged: (value) {
              touched = true;
              this.value = value;
              handleChange(value);
              triggerChange();
            },
          ),
        ],
      ),
    );
  }
}

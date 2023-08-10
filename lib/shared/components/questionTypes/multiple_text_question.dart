import 'package:flutter/material.dart';

import 'question.dart';

class TextQuestion extends Question {
  TextQuestion({
    required String question,
    required Function onChange,
    this.hint = 'Input here',
  }) : super(
          question: question,
          onChange: onChange,
        );

  final String hint;
  bool touched = false;
  int numberOfTextFields = 1;

  @override
  bool get isValid {
    return value is List<String> && !value.isEmpty;
  }

  @override
  String? get error {
    if (isValid || !touched) {
      return null;
    }
    return 'Please enter some text';
  }

  List<String> addValueToList(String value) {
    if (this.value == null) {
      this.value = [];
    }
    this.value.add(value);
    return this.value;
  }

  @override
  build(BuildContext context, Function triggerChange) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [
          for (int i = 0; i < numberOfTextFields; i++)
            TextField(
              decoration: InputDecoration(
                errorText: error,
                hintText: hint,
              ),
              onChanged: (value) {
                touched = true;
                this.value = addValueToList(value);
                onChange(value);
                triggerChange();
              },
            ),
          FloatingActionButton(
            onPressed: () {
              numberOfTextFields++;
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

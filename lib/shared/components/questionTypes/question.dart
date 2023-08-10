import 'package:flutter/material.dart';

class Question {
  Question({required this.question, required this.onChange, this.subtitle});

  final String question;
  final String? subtitle;
  final Function onChange;
  dynamic value;

  bool get isValid {
    return value != null && !value.isEmpty;
  }

  String? get error {
    if (isValid) {
      return null;
    }
    return 'Please enter some text';
  }

  build(BuildContext context, Function triggerChange) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          IconButton(
              onPressed: () {
                value = 'yes';
                triggerChange();
              },
              icon: const Icon(Icons.check)),
        ],
      ),
    );
  }
}

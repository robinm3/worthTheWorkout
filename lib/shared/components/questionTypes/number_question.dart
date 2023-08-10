import 'text_question.dart';

class NumberQuestion extends TextQuestion {
  NumberQuestion({
    required String question,
    required Function onChange,
    this.min = 0,
    this.max = 3600,
    hint = '1',
    subtitle,
  }) : super(
          question: question,
          onChange: onChange,
          subtitle: subtitle,
          hint: hint,
        );

  final int min;
  final int max;

  @override
  bool get isValid {
    if (value is int) {
      if (value >= min && value <= max) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  String? get error {
    if (isValid || !touched) {
      return null;
    }
    return 'Please enter a number between $min and $max';
  }

  @override
  void handleChange(String value) {
    if (value.isEmpty) {
      this.value = 0;
    } else {
      int? parsedValue = int.tryParse(value);
      if (parsedValue == null) {
        this.value = 0;
      } else {
        this.value = parsedValue;
      }
    }
    onChange(this.value);
  }
}

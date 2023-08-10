class WorkoutRequest {
  WorkoutRequest({
    required this.muscleGroup,
    required this.label,
    required this.exercices,
  });
  final String muscleGroup;
  final String label;
  final List<String> exercices;
}

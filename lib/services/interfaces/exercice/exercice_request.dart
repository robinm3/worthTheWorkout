class ExerciceRequest {
  ExerciceRequest({
    required this.label,
    required this.image,
    required this.repType,
    required this.sets,
    required this.restTime,
    this.time,
    this.videoLink,
  });

  final String label;
  final String image;
  final String repType;
  final String? videoLink;
  final int sets;
  final int restTime;
  final int? time;
}

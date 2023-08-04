class Workout {
  const Workout({
    required this.name,
    required this.exercices,
  });

  final String name;
  final List<Exercice> exercices;
}

class Exercice {
  const Exercice({
    required this.name,
    required this.imageLink,
    required this.timeForRep,
    required this.repCount,
    required this.setCount,
    required this.restTime,
    required this.toFailure,
    this.videoLink,
  });

  final String name;
  final String imageLink;
  final int timeForRep;
  final int repCount;
  final int setCount;
  final int restTime;
  final bool toFailure;
  final String? videoLink;
}

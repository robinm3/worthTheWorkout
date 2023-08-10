class Workout {
  const Workout({
    required this.name,
    required this.exercices,
  });

  final String name;
  final List<Exercice> exercices;

  static Workout fromDto(
      Map<String, dynamic> workoutSnapshot, List<Exercice> exercices) {
    return Workout(
      name: workoutSnapshot["label"],
      exercices: exercices,
    );
  }
}

class BaseWorkout {
  const BaseWorkout({
    required this.name,
    required this.id,
  });

  final String name;
  final String id;
}

class Exercice {
  const Exercice({
    required this.id,
    required this.name,
    required this.imageLink,
    required this.timeForRep,
    required this.repCount,
    required this.setCount,
    required this.restTime,
    required this.toFailure,
    this.videoLink,
  });

  final String id;
  final String name;
  final String imageLink;
  final int timeForRep;
  final int repCount;
  final int setCount;
  final int restTime;
  final bool toFailure;
  final String? videoLink;

  static Exercice fromData(Map<String, dynamic>? data, String id) {
    switch (data!["repType"]) {
      case "time":
        return Exercice(
          id: id,
          name: data["label"],
          imageLink: data["image"],
          timeForRep: data["time"] ??= 50,
          repCount: 1,
          setCount: data["sets"] ??= 3,
          restTime: data["rest"] ??= 60,
          toFailure: false,
          videoLink: data["videoLink"],
        );
      case "defaultRep":
        return Exercice(
          id: id,
          name: data["label"],
          imageLink: data["image"],
          timeForRep: 2,
          repCount: 10,
          setCount: 4,
          restTime: 60,
          toFailure: false,
          videoLink: data["videoLink"],
        );
      case "doubleRep":
        return Exercice(
          id: id,
          name: data["label"],
          imageLink: data["image"],
          timeForRep: 2,
          repCount: 10,
          setCount: 4,
          restTime: 60,
          toFailure: false,
          videoLink: data["videoLink"],
        );
      default:
        return Exercice(
          id: id,
          name: data["label"],
          imageLink: data["image"],
          timeForRep: 2,
          repCount: 10,
          setCount: 4,
          restTime: 60,
          toFailure: false,
          videoLink: data["videoLink"],
        );
    }
  }
}

class WorkoutDto extends Object {
  const WorkoutDto({
    required this.name,
    required this.exercices,
  });
  final String name;
  final List<String> exercices;
}

class ExerciceDto extends Object {
  const ExerciceDto({
    required this.label,
    required this.image,
    required this.repType,
    required this.videoLink,
  });
  final String label;
  final String image;
  final RepType repType;
  final String videoLink;
}

enum RepType {
  time,
  defaultRep,
  doubleRep,
}

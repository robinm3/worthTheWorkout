import 'package:cloud_firestore/cloud_firestore.dart';

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

  static Exercice fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>?> exerciceSnapshot) {
    switch (exerciceSnapshot.data()!["repType"]) {
      case "time":
        return Exercice(
          name: exerciceSnapshot.data()!["label"],
          imageLink: exerciceSnapshot.data()!["image"],
          timeForRep: exerciceSnapshot.data()!["time"] ??= 50,
          repCount: 1,
          setCount: 4,
          restTime: 60,
          toFailure: false,
          videoLink: exerciceSnapshot.data()!["videoLink"],
        );
      case "defaultRep":
        return Exercice(
          name: exerciceSnapshot.data()!["label"],
          imageLink: exerciceSnapshot.data()!["image"],
          timeForRep: 2,
          repCount: 10,
          setCount: 4,
          restTime: 60,
          toFailure: false,
          videoLink: exerciceSnapshot.data()!["videoLink"],
        );
      case "doubleRep":
        return Exercice(
          name: exerciceSnapshot.data()!["label"],
          imageLink: exerciceSnapshot.data()!["image"],
          timeForRep: 2,
          repCount: 10,
          setCount: 4,
          restTime: 60,
          toFailure: false,
          videoLink: exerciceSnapshot.data()!["videoLink"],
        );
      default:
        return Exercice(
          name: exerciceSnapshot.data()!["label"],
          imageLink: exerciceSnapshot.data()!["image"],
          timeForRep: 2,
          repCount: 10,
          setCount: 4,
          restTime: 60,
          toFailure: false,
          videoLink: exerciceSnapshot.data()!["videoLink"],
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

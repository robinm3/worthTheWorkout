import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout/services/types/workout_types.dart';

import 'interfaces/exercice/exercice_repo.dart';
import 'interfaces/exercice/exercice_request.dart';

class ExerciceService {
  ExerciceService(this.exerciceRepo);
  final ExerciceRepo exerciceRepo;

  final CollectionReference exercicesCollection =
      FirebaseFirestore.instance.collection("exercices");

  Future<void> createExercice(String label, String image, String repType,
      int sets, int restTime, int time) async {
    await exerciceRepo.addExercice(ExerciceRequest(
        label: label,
        image: image,
        repType: repType,
        sets: sets,
        restTime: restTime,
        time: time));
  }

  Future<List<Exercice>> getExercices() async {
    return await exerciceRepo.getExercices();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout/services/interfaces/exercice/exercice_repo.dart';
import 'package:workout/services/interfaces/exercice/exercice_request.dart';

import '../../types/workout_types.dart';

class FirestoreExerciceRepo extends ExerciceRepo {
  final CollectionReference exercicesCollection =
      FirebaseFirestore.instance.collection("exercices");
  @override
  Future<void> addExercice(ExerciceRequest exercice) async {
    await exercicesCollection.add({
      "label": exercice.label,
      "image": exercice.image,
      "repType": exercice.repType,
      "rest": exercice.restTime,
      "sets": exercice.sets,
      "time": exercice.time,
    });
  }

  @override
  Future<void> deleteExercice(int id) async {
    await exercicesCollection.doc(id.toString()).delete();
  }

  @override
  Future<Exercice> getExercice(String id) async {
    final DocumentSnapshot exerciceSnapshot =
        await exercicesCollection.doc(id).get();
    return Exercice.fromData(
        exerciceSnapshot.data() as Map<String, dynamic>?, exerciceSnapshot.id);
  }

  @override
  Future<List<Exercice>> getExercices() async {
    final QuerySnapshot exercicesSnapshot = await exercicesCollection.get();
    final List<Exercice> exercices = [];
    for (final QueryDocumentSnapshot exerciceSnapshot
        in exercicesSnapshot.docs) {
      exercices.add(Exercice.fromData(
          exerciceSnapshot.data() as Map<String, dynamic>?,
          exerciceSnapshot.id));
    }
    return exercices;
  }
}

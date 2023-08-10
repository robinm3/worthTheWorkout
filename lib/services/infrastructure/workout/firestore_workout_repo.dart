import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout/services/interfaces/workout/workout_repo.dart';
import 'package:workout/services/interfaces/workout/workout_request.dart';

import '../../types/workout_types.dart';

class FirestoreWorkoutRepo extends WorkoutRepo {
  final CollectionReference workoutsCollection =
      FirebaseFirestore.instance.collection("workouts");
  final CollectionReference exercicesCollection =
      FirebaseFirestore.instance.collection("exercices");

  @override
  Future<void> addWorkout(WorkoutRequest workoutRequest) async {
    await workoutsCollection.add({
      "label": workoutRequest.label,
      "exercices": workoutRequest.exercices,
    });
  }

  @override
  Future<void> deleteWorkout(String id) async {
    await workoutsCollection.doc(id).delete();
  }

  @override
  Future<Workout> getWorkout(String id) async {
    final DocumentSnapshot workoutSnapshot =
        await workoutsCollection.doc(id).get();
    if (workoutSnapshot.data() == null) {
      throw Exception("No workout found for id $id");
    }
    final Map<String, dynamic> workoutCollectionData =
        workoutSnapshot.data() as Map<String, dynamic>;
    final List<String> exerciceIds =
        List<String>.from(workoutCollectionData["exercices"]);
    final List<Exercice> exercices = [];
    for (final String exerciceId in exerciceIds) {
      final DocumentSnapshot exerciceSnapshot =
          await exercicesCollection.doc(exerciceId).get();
      exercices.add(Exercice.fromData(
          exerciceSnapshot.data() as Map<String, dynamic>?, exerciceId));
    }
    return Workout.fromDto(workoutCollectionData, exercices);
  }

  @override
  Future<List<BaseWorkout>> getBaseWorkouts() async {
    final QuerySnapshot workoutsSnapshot = await workoutsCollection.get();
    final List<BaseWorkout> workouts = [];
    for (final QueryDocumentSnapshot workoutSnapshot in workoutsSnapshot.docs) {
      Map<String, dynamic>? workoutData =
          workoutSnapshot.data() as Map<String, dynamic>?;
      if (workoutData == null) {
        throw Exception("No workout found for id ${workoutSnapshot.id}");
      }
      workouts
          .add(BaseWorkout(name: workoutData["label"], id: workoutSnapshot.id));
    }
    return workouts;
  }
}

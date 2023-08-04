import '../types/workout_types.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutService {
  WorkoutService();

  final CollectionReference workoutsCollection =
      FirebaseFirestore.instance.collection("workouts");
  final CollectionReference exercicesCollection =
      FirebaseFirestore.instance.collection("exercices");

  Future<List<String>> getWorkoutNamesForMuscle(String muscleId) async {
    final List<String> workoutNames = [];
    final DocumentSnapshot workoutSnapshot =
        await workoutsCollection.doc(muscleId).get();
    if (workoutSnapshot.data() == null) {
      throw Exception("No workout found for id $muscleId");
    }
    final Map<String, dynamic> workoutCollectionData =
        workoutSnapshot.data() as Map<String, dynamic>;
    final List<Map<String, dynamic>> workouts =
        List<Map<String, dynamic>>.from(workoutCollectionData["workouts"]);

    for (final Map<String, dynamic> workout in workouts) {
      workoutNames.add(workout["label"]);
    }

    return workoutNames;
  }

  Future<Workout> getWorkoutForMuscle(String muscleId, int workoutIndex) async {
    final DocumentSnapshot workoutSnapshot =
        await workoutsCollection.doc(muscleId).get();
    if (workoutSnapshot.data() == null) {
      throw Exception("No workout found for id $muscleId");
    }
    final Map<String, dynamic> workoutCollectionData =
        workoutSnapshot.data() as Map<String, dynamic>;
    final List<String> exerciceIds = List<String>.from(
        workoutCollectionData["workouts"][workoutIndex]["exercices"]);
    final List<Exercice> exercices = [];
    for (final String exerciceId in exerciceIds) {
      final DocumentSnapshot exerciceSnapshot =
          await exercicesCollection.doc(exerciceId).get();
      exercices.add(Exercice.fromSnapshot(
          exerciceSnapshot as DocumentSnapshot<Map<String, dynamic>?>));
    }
    return Workout.fromDto(
        workoutCollectionData["workouts"][workoutIndex], exercices);
  }
}

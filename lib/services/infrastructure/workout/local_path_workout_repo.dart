import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

import 'package:workout/services/interfaces/workout/workout_repo.dart';

import '../../interfaces/workout/workout_request.dart';
import '../../types/workout_types.dart';

class LocalPathWorkoutRepo extends WorkoutRepo {
  Future<File> get _localWorkoutsFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/workouts.json');
  }

  Future<File> get _localExercicesFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/exercices.json');
  }

  @override
  Future<void> addWorkout(WorkoutRequest workoutRequest) async {
    final file = await _localWorkoutsFile;
    String fileContent = await file.readAsString();
    final Map<String, dynamic> workouts = jsonDecode(fileContent);
    String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
    workouts[uniqueId] = {
      "label": workoutRequest.label,
      "exercices": workoutRequest.exercices,
    };
    await file.writeAsString(jsonEncode(workouts));
  }

  @override
  Future<void> deleteWorkout(String id) async {
    final file = await _localWorkoutsFile;
    String fileContent = await file.readAsString();
    final Map<String, dynamic> workouts = jsonDecode(fileContent);
    workouts.remove(id);
    await file.writeAsString(jsonEncode(workouts));
  }

  @override
  Future<Workout> getWorkout(String id) async {
    final file = await _localWorkoutsFile;
    String fileContent = await file.readAsString();
    final Map<String, dynamic> workouts = jsonDecode(fileContent);
    final Map<String, dynamic> workout = workouts[id] as Map<String, dynamic>;
    final List<String> exerciceIds = List<String>.from(workout["exercices"]);
    final exerciceFile = await _localExercicesFile;
    String exerciceFileContent = await exerciceFile.readAsString();
    final Map<String, dynamic> allExercices = jsonDecode(exerciceFileContent);
    final List<Exercice> exercicesForWorkout = [];
    for (final String exerciceId in exerciceIds) {
      exercicesForWorkout.add(Exercice.fromData(
          allExercices[exerciceId] as Map<String, dynamic>?, exerciceId));
    }
    return Workout.fromDto(workout, exercicesForWorkout);
  }

  @override
  Future<List<BaseWorkout>> getBaseWorkouts() async {
    final file = await _localWorkoutsFile;
    String fileContent = await file.readAsString();
    final Map<String, dynamic> workouts = jsonDecode(fileContent);
    final List<BaseWorkout> baseWorkouts = [];
    for (final String workoutId in workouts.keys) {
      final Map<String, dynamic> workout =
          workouts[workoutId] as Map<String, dynamic>;
      baseWorkouts.add(BaseWorkout(name: workout["label"], id: workoutId));
    }
    return baseWorkouts;
  }
}

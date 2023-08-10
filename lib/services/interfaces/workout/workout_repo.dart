import 'package:workout/services/interfaces/workout/workout_request.dart';

import '../../types/workout_types.dart';

abstract class WorkoutRepo {
  Future<List<BaseWorkout>> getBaseWorkouts();
  Future<Workout> getWorkout(String id);
  Future<void> addWorkout(WorkoutRequest workoutRequest);
  Future<void> deleteWorkout(String id);
}

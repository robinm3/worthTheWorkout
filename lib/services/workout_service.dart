import 'package:workout/services/interfaces/workout/workout_repo.dart';

import 'interfaces/workout/workout_request.dart';
import 'types/workout_types.dart';

class WorkoutService {
  WorkoutService(this.workoutRepo);

  final WorkoutRepo workoutRepo;

  Future<List<BaseWorkout>> getWorkouts() async {
    return await workoutRepo.getBaseWorkouts();
  }

  Future<Workout> getWorkout(String workoutId) async {
    return await workoutRepo.getWorkout(workoutId);
  }

  Future<void> createWorkout(
      String muscleId, String label, List<String> exerciceIds) async {
    await workoutRepo.addWorkout(WorkoutRequest(
        muscleGroup: muscleId, label: label, exercices: exerciceIds));
  }
}

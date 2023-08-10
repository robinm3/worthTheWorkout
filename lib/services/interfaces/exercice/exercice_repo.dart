import 'package:workout/services/interfaces/exercice/exercice_request.dart';

import '../../types/workout_types.dart';

abstract class ExerciceRepo {
  Future<List<Exercice>> getExercices();
  Future<Exercice> getExercice(String id);
  Future<void> addExercice(ExerciceRequest exercice);
  Future<void> deleteExercice(int id);
}

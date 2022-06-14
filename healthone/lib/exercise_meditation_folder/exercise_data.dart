import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'exercise.dart';
import 'db_things.dart';

class ExerciseData extends ChangeNotifier{
  List<Exercise> exercises = [];

  void addExercise(String exercise_name, String exercise_type,double metabolic_equivalent_score) async {
    Exercise exercise = await DbThings.addExercise(exercise_name,exercise_type,metabolic_equivalent_score);
    exercises.add(exercise);
    notifyListeners();
  }


}
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'exercise.dart';
import 'db_things.dart';
import 'student_exercising.dart';
import '../profile/student.dart';

class ExerciseData extends ChangeNotifier{
  List<Exercise> exercises = [];
  List<StudentExercising> studentExercises = [];

  void addExercise(String exercise_name, String exercise_type,double metabolic_equivalent_score) async {
    Exercise exercise = await DbThings.addExercise(exercise_name,exercise_type,metabolic_equivalent_score);
    exercises.add(exercise);
    notifyListeners();
  }

  void addStudentExercising(Exercise exercise, Student student,DateTime started_at, DateTime ended_at) async {
    StudentExercising studentExercising = await DbThings.addStudentExercising(exercise,student,started_at,ended_at);
    studentExercises.add(studentExercising);
    notifyListeners();
  }

  void updateStudentExercisingTime(StudentExercising studentExercising){
    studentExercising.updateEndTime();
    DbThings.updateStudentExercising(studentExercising.student_exercising_id);
    notifyListeners();
  }


}
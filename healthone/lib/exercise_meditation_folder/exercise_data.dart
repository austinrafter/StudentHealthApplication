import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'exercise.dart';
import 'db_things.dart';
import 'student_exercising.dart';
import '../profile/student.dart';
import 'pass_exercise.dart';

class ExerciseData extends ChangeNotifier{
  List<Exercise> exercises = [];
  List<StudentExercising> studentExercises = [];
  List<Student> students = [];
  List<PassExercise> passExercises = [];

  void addExercise(String exercisename, String exercisetype,double metabolicequivalentscore) async {
    Exercise exercise = await DbThings.addExercise(exercisename,exercisetype,metabolicequivalentscore);
    exercises.add(exercise);
    notifyListeners();
  }

  void addStudentExercising(String exercisename, String username,DateTime startedat, DateTime endedat, int totaltime, double caloriesburned) async {
    PassExercise studentExercising = await DbThings.addStudentExercising(exercisename,username,startedat,endedat, totaltime, caloriesburned);
    passExercises.add(studentExercising);
    notifyListeners();
  }

  void updateStudentExercisingTime(StudentExercising studentExercising){
    studentExercising.updateEndTime();
    DbThings.updateStudentExercising(studentExercising.studentexercisingid);
    notifyListeners();
  }


  

}
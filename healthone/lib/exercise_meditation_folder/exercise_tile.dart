import 'package:flutter/material.dart';
import '../exercise_meditation_folder/exercise.dart';
import '../exercise_meditation_folder/exercise_data.dart';

class ExerciseTile extends StatelessWidget{
  final Exercise exercise;
  final ExerciseData exerciseData;

  const ExerciseTile({Key? key, required this.exercise, required this.exerciseData}) : super(key: key);

  @override
  Widget build(BuildContext context){
  return Card(
      child: ListTile(
      title: Text(
      exercise.exerciseName,
      ),
      trailing: Text(
      exercise.exerciseType,
      ),
      ),
      );
  }
}
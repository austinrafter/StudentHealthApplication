import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../exercise_meditation_folder/print_exercises.dart';
import '../exercise_meditation_folder/exercise_tile.dart';
import '../exercise_meditation_folder/exercise.dart';
import '../exercise_meditation_folder/exercise_data.dart';
import '../exercise_meditation_folder/exercise_for_given_time.dart';
import '../exercise_meditation_folder/print_exercises.dart';



class ExerciseTimerPage extends StatelessWidget {
  final Exercise exercise;
  final String exercise_name;
  final String exercise_type;
  final double metabolic_equivalent_score;
  const ExerciseTimerPage({Key? key,required this.exercise, required this.exercise_name, required this.exercise_type, required this.metabolic_equivalent_score}) : super(key: key);
  static const routeName = '/passArguments';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExerciseData>(
      create: (context) => ExerciseData(),
      child: Container(
        child: ExerciseCountdown(exercise: exercise, exercise_name: exercise_name, exercise_type: exercise_type, metabolic_equivalent_score: metabolic_equivalent_score),
      ),//Container

    );//ChangeNotifierProvider
  }
}
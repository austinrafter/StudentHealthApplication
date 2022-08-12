import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../exercise_meditation_folder/print_exercises.dart';
import '../exercise_meditation_folder/exercise_tile.dart';
import '../exercise_meditation_folder/exercise.dart';
import '../exercise_meditation_folder/exercise_data.dart';
import '../exercise_meditation_folder/exercise_for_given_time.dart';
import '../exercise_meditation_folder/print_exercises.dart';
import '../exercise_meditation_folder/daily_exercise_info.dart';
import 'lift_weights.dart';


class WeightLiftingPage  extends StatelessWidget {
  final Exercise exercise;
  final String exercisename;
  final String exercisetype;
  final double metabolicequivalentscore;
  const WeightLiftingPage({Key? key,required this.exercise, required this.exercisename, required this.exercisetype, required this.metabolicequivalentscore}) : super(key: key);
  //static const routeName = '/passArguments';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExerciseData>(
      create: (context) => ExerciseData(),
      child: Container(
        child: WeightLiftingExercise(exercise: exercise, exercisename:exercise.exercisename, exercisetype:exercise.exercisetype, metabolicequivalentscore:exercise.metabolicequivalentscore),
      ),//MaterialApp
    );//ChangeNotifierProvider
  }//build
}
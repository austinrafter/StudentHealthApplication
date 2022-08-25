import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../exercise_meditation_folder/print_exercises.dart';
import '../exercise_meditation_folder/exercise_tile.dart';
import '../exercise_meditation_folder/exercise.dart';
import '../exercise_meditation_folder/exercise_data.dart';
import '../exercise_meditation_folder/exercise_for_given_time.dart';



class ExerciseTypePage extends StatelessWidget {
  const ExerciseTypePage({Key? key, required this.exercisetype}) : super(key: key);
  final String exercisetype;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExerciseData>(
      create: (context) => ExerciseData(),
      child: Container(
        child: PrintExercises(exerciser: exercisetype),
      ),//MaterialApp
    );//ChangeNotifierProvider
  }//build
}//class

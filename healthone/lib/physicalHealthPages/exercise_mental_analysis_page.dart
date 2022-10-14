import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../exercise_meditation_folder/print_exercises.dart';
import '../exercise_meditation_folder/exercise_mental_tile.dart';
import '../exercise_meditation_folder/exercise_mental_comparison.dart';
import '../exercise_meditation_folder/exercise_data.dart';
import '../exercise_meditation_folder/exercise_for_given_time.dart';
import '../exercise_meditation_folder/print_exercise_mental.dart';



class ExerciseMentalPage extends StatelessWidget {
  const ExerciseMentalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExerciseData>(
      create: (context) => ExerciseData(),
      child: Container(
        child: PrintExerciseMental(),
      ),//MaterialApp
    );//ChangeNotifierProvider
  }//build
}//class
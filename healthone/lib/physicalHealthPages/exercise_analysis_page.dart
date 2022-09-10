import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../exercise_meditation_folder/print_exercises.dart';
import '../exercise_meditation_folder/exercise_tile.dart';
import '../exercise_meditation_folder/exercise.dart';
import '../exercise_meditation_folder/exercise_data.dart';
import '../exercise_meditation_folder/exercise_for_given_time.dart';
import '../exercise_meditation_folder/print_exercises.dart';
import '../exercise_meditation_folder/daily_exercise_info.dart';
import '../exercise_meditation_folder/exercise_analysis_charts.dart';


class ExerciseAnalysisPage extends StatelessWidget {

  const ExerciseAnalysisPage({Key? key}) : super(key: key);
  //static const routeName = '/passArguments';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExerciseData>(
      create: (context) => ExerciseData(),
      child: Container(
        child: PrintExerciseAnalysisCharts(),
      ),//MaterialApp
    );//ChangeNotifierProvider
  }//build
}
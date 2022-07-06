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
  const ExerciseTimerPage({Key? key,required this.exercise, required this.exercise_name, required this.exercise_type}) : super(key: key);
  static const routeName = '/passArguments';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExerciseData>(
      create: (context) => ExerciseData(),
      child: Container(
        //title: "HealthOne",

       // theme: ThemeData(
         // primaryColor: Colors.teal[400],
        //),
        //debugShowCheckedModeBanner: false,
        child: ExerciseCountdown(exercise: exercise, exercise_name: exercise_name, exercise_type: exercise_type),
        /*
        routes: <String, WidgetBuilder> {
          '/a': (BuildContext context) => PrintExercises(),
        },
         */
      ),

    );
  }
}
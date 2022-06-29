import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../exercise_meditation_folder/print_exercises.dart';
import '../exercise_meditation_folder/exercise_tile.dart';
import '../exercise_meditation_folder/exercise.dart';
import '../exercise_meditation_folder/exercise_data.dart';
import '../exercise_meditation_folder/exercise_for_given_time.dart';



class ExerciseTypePage extends StatelessWidget {
  const ExerciseTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExerciseData>(
      create: (context) => ExerciseData(),
      child: MaterialApp(
        title: "HealthOne",

        theme: ThemeData(
          primaryColor: Colors.teal[400],
        ),
        debugShowCheckedModeBanner: false,
        home: PrintExercises(),
      ),

    );
  }
}

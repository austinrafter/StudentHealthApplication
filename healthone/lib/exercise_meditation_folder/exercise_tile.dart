import 'package:flutter/material.dart';
import '../exercise_meditation_folder/exercise.dart';
import '../exercise_meditation_folder/exercise_data.dart';
import '../exercise_meditation_folder/exercise_for_given_time.dart';
import '../exercise_meditation_folder/exercise_timer_page.dart';



class ExerciseTile extends StatelessWidget{
  final Exercise exercise;
  final ExerciseData exerciseData;

  const ExerciseTile({Key? key, required this.exercise, required this.exerciseData,}) : super(key: key);

  @override
  Widget build(BuildContext context){
  return Container(
    child: ElevatedButton(
      onPressed: () {
        // When the user taps the button, navigate
        // to a named route and provide the arguments
        // as an optional parameter.
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  ExerciseTimerPage(exercise: exercise, exercise_name:exercise.exercise_name, exercise_type:exercise.exercise_type),),
        );
      },
    child: Card(

      child: ListTile(
        leading: Text(exercise.exercise_type,),
      title: Text(
      exercise.exercise_name,
      ),//Text
      trailing: Text(
      exercise.metabolic_equivalent_score.toString(),
      ),//Text
      ),//ListTile
      ),//Card
  ),//ElevatedButton
  );//Container
  }
}


class CountdownArguments{
  final Exercise exercise;
  final String exercise_name;
  final String exercise_type;

  CountdownArguments(this.exercise, this.exercise_name, this.exercise_type);
}
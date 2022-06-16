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
    child: Stack(
      children: [
        Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: ListTile(
      title: Text(
      exercise.exercise_name,
      ),//Text
        subtitle: Text(exercise.exercise_type,),
      trailing: Text(
      'MET\n${exercise.metabolic_equivalent_score.toString()}',
        style: const TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 18
        ),//TextStyle
      ),//Text
      ),//ListTile
      ),//Card
    ],//stack children
    ),//Stack
  ),//ElevatedButton
  );//Container
  }//build

}//class


class CountdownArguments{
  final Exercise exercise;
  final String exercise_name;
  final String exercise_type;

  CountdownArguments(this.exercise, this.exercise_name, this.exercise_type);
}
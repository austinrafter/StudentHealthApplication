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
          MaterialPageRoute(builder: (context) =>  ExerciseTimerPage(exercise: exercise, exercisename:exercise.exercisename, exercisetype:exercise.exercisetype, metabolicequivalentscore:exercise.metabolicequivalentscore),),
        );//navigator.push
      },//onpressed
    child: Stack(
      children: [
        Card(
          color: Colors.teal[400],
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),//borderside
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),//roundedrectangleborder
      child: ListTile(
      title: Text(
      exercise.exercisename,
      ),//Text
        subtitle: Text(exercise.exercisetype,),
      trailing: Text(
      'MET\n${exercise.metabolicequivalentscore.toString()}',
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
  final String exercisename;
  final String exercisetype;

  CountdownArguments(this.exercise, this.exercisename, this.exercisetype);
}
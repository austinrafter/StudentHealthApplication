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
      style: ElevatedButton.styleFrom(
        primary: Colors.teal[900],
      ),
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
          color: Colors.teal[600],
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.teal.shade600,
        ),//borderside
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),//roundedrectangleborder
      child: ListTile(
        leading: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 46,
            minHeight: 46,
            maxWidth: 66,
            maxHeight: 66,
          ),
          child:
          exercise.exerciseimage == null ?
          Image.network(
            'https://media.giphy.com/media/4bjIKBOWUnVPICCzJc/giphy.gif',
            width: double.infinity,
            height: 350,
            //fit: Boxfit.cover
          )//image.network
              : Image.network(
            '${exercise.exerciseimage}',
            width: double.infinity,
            height: 350,
            //fit: Boxfit.cover
          ),//image.network
        ),//ConstrainedBox
      title: Text(
      exercise.exercisename,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,),
      ),//Text
        subtitle: Text(exercise.exercisetype,
          style: TextStyle(fontStyle: FontStyle.italic,
            color: Colors.white,),),
      trailing: Text(
      'MET\n${exercise.metabolicequivalentscore.toString()}',
        style: const TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 18,
            color: Colors.white,
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
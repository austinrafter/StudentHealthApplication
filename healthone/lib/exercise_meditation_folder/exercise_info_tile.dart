import 'package:flutter/material.dart';
import '../exercise_meditation_folder/pass_exercise.dart';
import '../exercise_meditation_folder/exercise_data.dart';
import '../exercise_meditation_folder/exercise_for_given_time.dart';
import '../exercise_meditation_folder/exercise_timer_page.dart';



class ExerciseInfoTile extends StatelessWidget{
  final PassExercise passExercise;
  final ExerciseData passexerciseData;

  const ExerciseInfoTile({Key? key, required this.passExercise, required this.passexerciseData,}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
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
                title: Text(
                  passExercise.exercisename,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,),
                ),//Text
                subtitle: Text(
                  passExercise.username,
                  style: TextStyle(fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),//TextStyle
                ),//Text
              ),//ListTile
            ),//Card
          ],//stack children
        ),//Stack
    );//Container
  }//build

}//class
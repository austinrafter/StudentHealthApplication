import 'package:flutter/material.dart';
import '../exercise_meditation_folder/exercise_mental_comparison.dart';
import '../exercise_meditation_folder/exercise_data.dart';
import '../exercise_meditation_folder/exercise_for_given_time.dart';
import '../exercise_meditation_folder/exercise_timer_page.dart';
import 'weight_lifing_page.dart';



class ExerciseMentalTile extends StatelessWidget{
  final ExerciseMentalComparison exerciseMental;
  final ExerciseData exerciseData;

  const ExerciseMentalTile({Key? key, required this.exerciseMental, required this.exerciseData,}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.teal[900],
        ),
        onPressed: () {

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
                leading: Text(
                  'Datel\n${exerciseMental.date}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,),
                ),//Text

                title: Text(
                  'Minutes Exercised: ${exerciseMental.minutes}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,),
                ),//Text
                subtitle: Text('Mood: ${exerciseMental.mood}\nStress Level: ${exerciseMental.stress}',
                  style: TextStyle(fontWeight: FontWeight.bold,
                    color: Colors.white,),),
                /*
                trailing: Text(
                  'Stress Level\n${exerciseMental.stress}',
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                    color: Colors.white,
                  ),//TextStyle
                ),//Text

                 */
                isThreeLine: true,
              ),//ListTile
            ),//Card
          ],//stack children
        ),//Stack
      ),//ElevatedButton
    );//Container
  }//build

}//class


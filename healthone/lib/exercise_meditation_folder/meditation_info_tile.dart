import 'package:flutter/material.dart';
import '../exercise_meditation_folder/pass_meditation.dart';
import '../exercise_meditation_folder/meditation_data.dart';
import '../exercise_meditation_folder/exercise_for_given_time.dart';
import '../exercise_meditation_folder/exercise_timer_page.dart';



class MeditationInfoTile extends StatelessWidget{
  final PassMeditation passMeditation;
  final MeditationData passmeditationData;

  const MeditationInfoTile({Key? key, required this.passMeditation, required this.passmeditationData,}) : super(key: key);

  @override
  Widget build(BuildContext context){
    var minutes = passMeditation.totaltime / 60;
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
                passMeditation.meditationname,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,),
              ),//Text
              subtitle: Text(
                '${minutes} minutes meditated',
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
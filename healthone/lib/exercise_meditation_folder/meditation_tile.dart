import 'package:flutter/material.dart';
import '../exercise_meditation_folder/meditation.dart';
import '../exercise_meditation_folder/meditation_data.dart';
import '../exercise_meditation_folder/perform_meditation.dart';
import '../exercise_meditation_folder/meditation_sound_page.dart';

class MeditationTile extends StatelessWidget{
  final Meditation meditation;
  final MeditationData meditationData;

  const MeditationTile({Key? key, required this.meditation, required this.meditationData,}) : super(key: key);

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
            MaterialPageRoute(builder: (context) =>  MeditationSoundPage(meditation: meditation, meditationname:meditation.meditationname, meditationtype:meditation.meditationtype, audiolink:meditation.audiolink, imagelink: meditation.imagelink),),
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
                  meditation.meditationname,
                ),//Text
                subtitle: Text(meditation.meditationtype,),
              ),//ListTile
            ),//Card
          ],//stack children
        ),//Stack
      ),//ElevatedButton
    );//Container
  }//build
}//class
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
      color: Colors.teal[900],
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
      style: ElevatedButton.styleFrom(
        primary: Colors.teal[900],
      ),
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
              child: Expanded(
                child: ListTile(
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 46,
                    minHeight: 46,
                    maxWidth: 66,
                    maxHeight: 66,
                  ),
                  child: meditation.imagelink == null ? Image.network(
                    'https://media.giphy.com/media/YhW0qsOoz8vb37vxFO/giphy.gif',
                    width: double.infinity,
                    height: 350,
                    //fit: Boxfit.cover
                  )//image.network
                      : Image.network(
                    '${meditation.imagelink}',
                    width: double.infinity,
                    height: 350,
                    //fit: Boxfit.cover
                  ),//image.network
                ),//ConstrainedBox
                title: Text(
                  meditation.meditationname,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,),
                ),//Text
                subtitle: Text(meditation.meditationtype,
                  style: TextStyle(fontStyle: FontStyle.italic,
                    color: Colors.white,),),
              ),//ListTile
              ),
            ),//Card
          ],//stack children
        ),//Stack
      ),//ElevatedButton
    );//Container
  }//build
}//class
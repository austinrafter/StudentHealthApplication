/*import 'package:flutter/material.dart';

class PerformMeditation extends StatelessWidget{
  const PerformMeditation({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Text(
            "Perform Meditation Page",
            style: TextStyle(fontSize:50),
          ),
        ),
      ),
    );
  }
}

 */


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'dart:io';


class PerformMeditation extends StatefulWidget{
  const PerformMeditation({Key? key}) : super(key : key);

  @override
  _PerformMeditationState createState() => _PerformMeditationState();
}

class _PerformMeditationState extends State<PerformMeditation>{
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState(){
    super.initState();

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState((){
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration){
      setState((){
        duration = newDuration;
      });
    });
  }

  Future setAudio() async{
    audioPlayer.setReleaseMode(ReleaseMode.loop);

    //String url = 'https://soundcloud.com/futureisnow/future-feat-drake-tems-wait?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing';
    final url = File('../exercise_meditation_folder/assets/Moria - Suffer.mp3');
    //audioPlayer.setUrl(url);
    //final player = AudioCache(prefix:'../healthone/lib/exercise_meditation_folder/assets');
    //final url = await player.load('Moria - Suffer.mp3');
    audioPlayer.setSourceUrl("https://moria831.bandcamp.com/track/of-flesh.mp3");
  }

  @override
  void dispose(){
    audioPlayer.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                  'https://neurosciencenews.com/files/2021/11/organsmic-meditation-brain-function-neuroscineces-public.jpg',
              width: double.infinity,
              height: 350,
              //fit: Boxfit.cover
              ),//image.network
    ),//ClipRRect
    const SizedBox(height: 32),
    const Text('Meditation Name',
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    ),//TextStyle
    ),//Text
    const SizedBox(height: 4),
    const Text(
    'meditation type',
    style: TextStyle(fontSize: 20),
    ),//Text
    Slider(
    min: 0,
    max: duration.inSeconds.toDouble(),
    value: position.inSeconds.toDouble(),
    onChanged: (value) async {
      final position = Duration(seconds: value.toInt());
      await audioPlayer.seek(position);

      //await audioPlayer.resume();
    },
    ),//slider
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children:[
      Text(//formatTime(position),
        position.toString(),
      ),
      Text(
        //formatTime(duration - position),
          (duration - position).toString(),
      ),
    ],//children
    ), //row
    ), //padding
    CircleAvatar(
    radius: 35,
    child: IconButton(
    icon: Icon(
    isPlaying ? Icons.pause : Icons.play_arrow,
    ),//Icon
    iconSize: 50,
    onPressed: () async {
      if(isPlaying){
        await audioPlayer.pause();
    }
      else{
        await audioPlayer.resume();
    }
    },//onPressed
    ),//Iconbutton
    ),//circleavatar
          ],//children
      ),//column
      ),//padding
    );//scaffold
  }




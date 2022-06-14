import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';


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

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState((){
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration){
      setState((){
        duration = newDuration;
      });
    });
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
                  'https://unsplash.com/s/photos/meditation',
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

      await audioPlayer.resume();
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
        String url = 'https://soundcloud.com/futureisnow/future-feat-drake-tems-wait?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing';
        await audioPlayer.play(url);
    }
    },//onPressed
    ),//Iconbutton
    ),//circleavatar
          ],//children
      ),//column
      ),//padding
    );//scaffold
  }


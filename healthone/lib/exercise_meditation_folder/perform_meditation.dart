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
import 'meditation.dart';
import '../profile/student.dart';
import 'pass_meditation.dart';
import 'meditation_data.dart';
import 'db_things.dart';


class PerformMeditation extends StatefulWidget{
  const PerformMeditation({Key? key, required this.meditation, required this.meditationname, required this.meditationtype, required this.audiolink, required this.imagelink}) : super(key : key);
  final Meditation meditation;
  final String meditationname;
  final String meditationtype;
  final String audiolink;
  final String imagelink;

  @override
  _PerformMeditationState createState() => _PerformMeditationState();
}

class _PerformMeditationState extends State<PerformMeditation>{
  final audioPlayer = AudioPlayer();
  Duration? _duration;
  Duration? _position;

  PlayerState _playerState = PlayerState.stopped;
  PlayerState? _audioPlayerState;

  bool get _isPlaying => _playerState == PlayerState.playing;
  bool get _isPaused => _playerState == PlayerState.paused;

  String get _durationText => _duration?.toString().split('.').first ?? '';
  String get _positionText => _position?.toString().split('.').first ?? '';

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  List<Student>? students;
  var totalTime = 0;
  var timePassed = 0;
  var start;
  var end;

  //bool isPlaying = false;

  getStudents()async{
    students = await DbThings.getStudents();
    Provider.of<MeditationData>(context, listen: false).students = students!;
  }

  @override
  void initState(){
    super.initState();
    getStudents();
    start = DateTime.now();
    setAudio();
    _initStreams();
  }

  Future setAudio() async{
    audioPlayer.setReleaseMode(ReleaseMode.stop);
    audioPlayer.setPlayerMode(PlayerMode.mediaPlayer);
    //await AudioPlayer.global.setGlobalAudioContext(config);
    AudioPlayer.global.changeLogLevel(LogLevel.info);
    //String url = 'https://soundcloud.com/futureisnow/future-feat-drake-tems-wait?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing';
      final url = UrlSource(
          widget.audiolink);
    //audioPlayer.setUrl(url);
    //final player = AudioCache(prefix:'../healthone/lib/exercise_meditation_folder/assets');
    //final url = await player.load('MoriaSuffer.mp3');
    print("gets here: audio player test set audio pre-play");
    final asset = AssetSource(widget.audiolink);
    if(Platform.isAndroid) {
      if(widget.audiolink.contains('https:')) {
        await audioPlayer.play(
          url,
          //mode: PlayerMode.media
        );
      }else {
        await audioPlayer.play(
          asset,
          //mode: PlayerMode.media
        );
      }
    }else{
      if(widget.audiolink.contains('https:')) {
        await audioPlayer.play(
          url,
          //mode: PlayerMode.media
        );
      }else {
        await audioPlayer.play(
          asset,
          //mode: PlayerMode.media
        );
      }
    }
    print("gets here: audio player test set audio post-play");
  }

  @override
  void dispose(){
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    audioPlayer.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.teal[900],
      title: Text("${widget.meditationname}"),
      centerTitle: true,
      leading: GestureDetector(
        onTap: (
            ) { Navigator.pop(context);
          _stop();
        if(_position != _duration){
          if(timePassed > 0) {
            totalTime = totalTime + timePassed;
          }
        }
        print(totalTime);
        end = DateTime.now();
        if(students?.length != 0){
          if(totalTime > 0) {
            Provider.of<MeditationData>(context, listen: false)
                .addStudentMeditating(widget.meditationname, Provider
                .of<MeditationData>(context, listen: false)
                .students[0].username, end, totalTime, widget.audiolink);
          }
        }//if

        },
        child: Icon(
          Icons.arrow_circle_left,
        ),//Icon
      ),//GestureDetector
    ),//AppBar
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
    buildImage(),
    const SizedBox(height: 32),
    buildName(),
    buildSlider(),
    buildText(),
    buildButton(),
          ],//children
      ),//column
      ),//padding
    );// widget build scaffold

  Widget buildText(){
    return Column(
      children:[
        Text(
          _position != null
              ? '$_positionText / $_durationText'
              : _duration != null
              ? _durationText
              : 'farts',
          style: const TextStyle(fontSize: 16.0),
        ),
        Text('State: $_audioPlayerState'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Text(//formatTime(position),
              _positionText,
            ),
            Text(
              //formatTime(duration - position),
              _durationText,
            ),
          ],//children
        ), //row
      ],//children
    );//Column
  }

  Widget buildButton(){
    return  CircleAvatar(
      radius: 35,
      child: IconButton(
        icon: Icon(
          _isPlaying ? Icons.pause : Icons.play_arrow,
        ),//Icon
        iconSize: 50,
        onPressed: () async {
          if(_isPlaying){
            print("gets here: audio player test pause");
            _pause();
          }else{
            print("gets here: audio player test resume");
            _play();
          }
        },//onPressed
      ),//Iconbutton
    );//circleavatar
  }

  Widget buildSlider(){
    return Slider(
      min: 0,
      value: (_position != null &&
          _duration != null &&
          _position!.inMilliseconds > 0 &&
          _position!.inMilliseconds < _duration!.inMilliseconds)
          ? _position!.inMilliseconds / _duration!.inMilliseconds
          : 0.0,
      onChanged: (value) async {
        //final position = Duration(seconds: value.toInt());
        //await audioPlayer.seek(position);
        final duration = _duration;
        if (duration == null) {
          return;
        }
        final position = value * duration.inMilliseconds;
        audioPlayer.seek(Duration(milliseconds: position.round()));

        //await audioPlayer.resume();
      },
    );//slider
  }


  Widget buildImage(){
    return Column(
      children:[
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: widget.imagelink == null ? Image.network(
            'https://media.giphy.com/media/YhW0qsOoz8vb37vxFO/giphy.gif',
            width: double.infinity,
            height: 350,
            //fit: Boxfit.cover
          )//image.network
              : Image.network(
            '${widget.imagelink}',
            width: double.infinity,
            height: 350,
            //fit: Boxfit.cover
          ),//image.network
        ),//ClipRRect
      ],
    );
  }

  Widget buildName(){
    return Column(
      children:[
        Text('${widget.meditationname}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),//TextStyle
        ),//Text
        const SizedBox(height: 4),
        Text(
          '${widget.meditationtype}',
          style: TextStyle(fontSize: 20),
        ),//Text
      ],
    );//Column
  }

  void _initStreams() {
    _durationSubscription = audioPlayer.onDurationChanged.listen((duration) {
      //totalTime = totalTime + 1;
      setState(() => _duration = duration);
    });

    _positionSubscription = audioPlayer.onPositionChanged.listen((p) {
          //print(p.inSeconds);
          if(p.inSeconds >= timePassed) {
            timePassed = p.inSeconds;
          }else{
            timePassed = timePassed + p.inSeconds;
          }
          setState(() => _position = p);

    });

    _playerCompleteSubscription = audioPlayer.onPlayerComplete.listen((event) {
      audioPlayer.stop();
      totalTime = totalTime + timePassed;
      timePassed = 0;
      setState(() {
        _playerState = PlayerState.stopped;
        _position = _duration;
      });
    });

    _playerStateChangeSubscription =
        audioPlayer.onPlayerStateChanged.listen((state) {
          setState(() {
            _audioPlayerState = state;
          });
        });
  }//_initStreams

  Future<void> _play() async {
    final position = _position;
    if (position != null && position.inMilliseconds > 0) {
      await audioPlayer.seek(position);
    }
    await audioPlayer.resume();
    setState(() => _playerState = PlayerState.playing);
  }//_play

  Future<void> _pause() async {
    await audioPlayer.pause();
    setState(() => _playerState = PlayerState.paused);
  }//_pause

  Future<void> _stop() async {
    await audioPlayer.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }//_stop

  }//class




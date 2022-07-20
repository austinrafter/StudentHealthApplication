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
  Duration? _duration;
  Duration? _position;

  PlayerState _playerState = PlayerState.stopped;
  PlayerState? _audioPlayerState;

  bool get isPlaying => _playerState == PlayerState.playing;
  bool get _isPaused => _playerState == PlayerState.paused;

  String get _durationText => _duration?.toString().split('.').first ?? '';
  String get _positionText => _position?.toString().split('.').first ?? '';

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  //bool isPlaying = false;

  @override
  void initState(){
    super.initState();

    setAudio();
    _initStreams();

    /*
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState((){
        print('Current player state: $state');
        print("gets here: audio player test state change");
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration){
      setState((){
        print("max duration: $newDuration");
        _duration = newDuration;
      });
    });

     */
  }

  Future setAudio() async{
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    audioPlayer.setPlayerMode(PlayerMode.mediaPlayer);
    //await AudioPlayer.global.setGlobalAudioContext(config);
    AudioPlayer.global.changeLogLevel(LogLevel.info);
    //String url = 'https://soundcloud.com/futureisnow/future-feat-drake-tems-wait?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing';
    final url = UrlSource('https://luan.xyz/files/audio/ambient_c_motion.mp3');
    //audioPlayer.setUrl(url);
    //final player = AudioCache(prefix:'../healthone/lib/exercise_meditation_folder/assets');
    //final url = await player.load('MoriaSuffer.mp3');
    print("gets here: audio player test set audio pre-play");
    final asset = AssetSource('audio/MoriaSuffer.mp3');
    if(Platform.isAndroid) {
      await audioPlayer.play(
          asset,
          //mode: PlayerMode.media
      );
    }else{
      audioPlayer.play(asset);
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
    ),//slider
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
    CircleAvatar(
    radius: 35,
    child: IconButton(
    icon: Icon(
    isPlaying ? Icons.pause : Icons.play_arrow,
    ),//Icon
    iconSize: 50,
    onPressed: () async {
      if(isPlaying){
        print("gets here: audio player test pause");
        _pause();
    }
      else{
        print("gets here: audio player test resume");
        _play();
    }
    },//onPressed
    ),//Iconbutton
    ),//circleavatar
          ],//children
      ),//column
      ),//padding
    );//scaffold

  void _initStreams() {
    _durationSubscription = audioPlayer.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = audioPlayer.onPositionChanged.listen(
          (p) => setState(() => _position = p),
    );

    _playerCompleteSubscription = audioPlayer.onPlayerComplete.listen((event) {
      audioPlayer.stop();
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
  }

  Future<void> _play() async {
    final position = _position;
    if (position != null && position.inMilliseconds > 0) {
      await audioPlayer.seek(position);
    }
    await audioPlayer.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    await audioPlayer.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  Future<void> _stop() async {
    await audioPlayer.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }
  }




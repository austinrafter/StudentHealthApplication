import 'dart:async';
import 'package:flutter/material.dart';
import 'exercise.dart';

class ExerciseCountdown extends StatefulWidget{
  const ExerciseCountdown({Key? key, required this.exercise, required this.exercise_name, required this.exercise_type}) : super(key : key);
  final Exercise exercise;
  final String exercise_name;
  final String exercise_type;
  //final int timerDuration;

  @override
  _ExerciseCountdownState createState() => _ExerciseCountdownState();
}

class _ExerciseCountdownState extends State<ExerciseCountdown>{
  static const countDownDuration = Duration(minutes: 10);
  Duration duration = Duration.zero;
  Timer? timer;

  bool isCountdown = true;

  @override
  void initState(){
    super.initState();

    //startTimer();
    reset();

  }

  void reset(){
    if(isCountdown){
      setState(() => duration = countDownDuration);
    }else {
      setState(() => duration = Duration());
    }
  }

  void addTime(){
    final addSeconds = isCountdown ? -1 : 1;
    setState((){
      final seconds = duration.inSeconds + addSeconds;

      if(seconds < 0 ){
        timer?.cancel();
      }else{
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer({bool resets = true}){
    if(resets){
      reset();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime() );
  }

  void stopTimer({bool resets = true}){
    if(resets){
      reset();
    }

    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.teal[900],
  ),
  backgroundColor: Colors.teal[400],
    body: Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTime(),
        const SizedBox(height: 80),
          buildButtons(),
        ],//children
      ),//Column
    ),//Center
  );//Scaffold

Widget buildTime(){
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits((duration.inMinutes.remainder(60)));
  final seconds = twoDigits((duration.inSeconds.remainder(60)));


  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text('${widget.exercise_name}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
              fontSize: 25,),
        ),
          const SizedBox(height: 24,),
        Text('${widget.exercise_type}',
          style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 25),
        ),
          const SizedBox(height: 24),
        ],

      ),//Column
      const SizedBox(height: 48,),
      Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children:[
      buildTimeCard(time: hours, header: 'HOURS'),
      const SizedBox(width: 8),
      buildTimeCard(time: minutes, header: 'MINUTES'),
      const SizedBox(width: 8),
      buildTimeCard(time: seconds, header: 'SECONDS'),

    ],

  ),//Row
  ],
  );//Column
}

Widget buildTimeCard({required String time, required String header}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
      padding: EdgeInsets.all(8),
  decoration: BoxDecoration(
    color: Colors.white,
  ),//BoxDecoration
  child: Text(
  time,
  style: TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 72
  ),//TextStyle
),//Text
),//Container
        const SizedBox(height: 24),
        Text(
          header
        ),
  ],
  );//Column

Widget buildButtons(){
  final isRunning = timer == null ? false : timer!.isActive;
  final isCompleted = duration.inSeconds == 0;
  return isRunning || !isCompleted
      ? Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          primary: Colors.white,
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          if(isRunning){
            stopTimer(resets: false);
          }else{
            startTimer(resets: false);
          }
        },//onPressed
        child: Text(
            (
                    () {
          if(isRunning){
            return "STOP";}
          else {
            return "RESUME";
          }
        }
        )()
        ),//Text
      ),//ButtonWidget
      const SizedBox(width: 12),
      TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          primary: Colors.white,
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: stopTimer,
        child: const Text('CANCEL'),
      ),//ButtonWidget
    ],//children

  )://Row
  TextButton(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(16.0),
      primary: Colors.white,
      textStyle: const TextStyle(fontSize: 20),
    ),
    onPressed: () {
      startTimer();
      },
    child: const Text('START TIME'),
  );//ButtonWidget
}

}
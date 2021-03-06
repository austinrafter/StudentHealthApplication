import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'exercise.dart';
import 'dart:convert';
import 'exercise_data.dart';
import 'db_things.dart';
import '../profile/student.dart';
import '../profile/profile_data.dart';
import '../profile/profile_db_services.dart';

class ExerciseCountdown extends StatefulWidget{
  const ExerciseCountdown({Key? key, required this.exercise, required this.exercisename, required this.exercisetype, required this.metabolicequivalentscore}) : super(key : key);
  final Exercise exercise;
  final String exercisename;
  final String exercisetype;
  final double metabolicequivalentscore;
  //final int timerDuration;

  @override
  _ExerciseCountdownState createState() => _ExerciseCountdownState();
}

class _ExerciseCountdownState extends State<ExerciseCountdown>{
  var countDownDuration;
  List<Student>? students;
  Duration duration = Duration.zero;
  Timer? timer;
  late TextEditingController _controller;
  var totalTime = 0;
  var start;
  var end;
  var caloriesBurnedPerMinute;
  var totalCaloriesBurned;

  getStudents()async{
    students = await DbThings.getStudents();
    Provider.of<ExerciseData>(context, listen: false).students = students!;
  }

  bool isCountdown = false;

  @override
  void initState(){
    super.initState();
    getStudents();
    //startTimer();
    reset();
    _controller = TextEditingController();
    start = DateTime.now();

  }

  void reset(){
    if(isCountdown){
        setState(() => duration = countDownDuration);
    }else {
      setState(() => duration = Duration());
    }
  }

  void cancel(){
      setState(() => duration = Duration());
      setState(() => timer?.cancel());
  }

  void addTime(){
    final addSeconds = isCountdown ? -1 : 1;
    setState((){
      final seconds = duration.inSeconds + addSeconds;
      totalTime = totalTime + 1;

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
  }//startTimer

  void stopTimer({bool resets = true}){
    if(resets){
      reset();
    }

    setState(() => timer?.cancel());
  }//stopTimer

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.teal[900],
      title: Text(""),
      leading: GestureDetector(
        onTap: (
            ) { Navigator.pop(context);
                print(totalTime);
                end = DateTime.now();
                print(start);
                print(end);
                print(widget.metabolicequivalentscore);
                if(students?.length != 0){
                  var kiloWeight = Provider.of<ExerciseData>(context, listen: false).students[0].weight * 0.453592;
                  caloriesBurnedPerMinute = (kiloWeight * 3.5 * widget.metabolicequivalentscore) / 200;
                  totalCaloriesBurned = caloriesBurnedPerMinute * (totalTime.toDouble() / 60);
                  print(totalCaloriesBurned);
                  print(Provider.of<ExerciseData>(context, listen: false).students[0].username);
                  print(widget.exercisename);
                  if(totalTime > 0) {
                    Provider.of<ExerciseData>(context, listen: false)
                        .addStudentExercising(widget.exercisename, Provider
                        .of<ExerciseData>(context, listen: false)
                        .students[0].username, start, end, totalTime,
                        totalCaloriesBurned);
                  }
                }
                },
        child: Icon(
          Icons.arrow_circle_left,
        ),
      ),
  ),//appBar
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
          Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  if(!isCountdown){
                    isCountdown = true;
                  }else{
                    isCountdown = false;
                  }
                },//onPressed
                child: Text(
                    (
                            () {
                          if(!isCountdown){
                            return "COUNTUP";}
                          else {
                            return "COUNTDOWN";
                          }
                        }
                    )()
                ),//Text
              ),//ButtonWidget
          ),//Align
        Text('${widget.exercisename}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
              fontSize: 25,),
        ),
          const SizedBox(height: 24,),
        Text('${widget.exercisetype}',
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
        ),//Text
  ],//children
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
        onPressed: cancel,
        child: const Text('CANCEL'),
      ),//ButtonWidget
    ],//children

  )://Row
  Column(
    children: [
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
  ),//TextButton
      const SizedBox(width: 12),
    TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter the number of minutes to exercise here',
      ),
          onSubmitted: (String value) async {
            await showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Thanks!'),
                  content: Text(
                      'You will ${widget.exercisename} for "$value" minutes.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        var minutes = int.parse(value);
                        countDownDuration = Duration(minutes: minutes);
                        print(countDownDuration);
                        isCountdown = true;
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),//TextButton
                  ],//actions
                );//AlertDialog
              },//builder
            );//await
          },//onsubmitted
          obscureText: false,

        ),//TextField
  ],
  );//Row
}

}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'exercise.dart';
import 'dart:convert';


class TimerTemplate extends StatefulWidget{
  const TimerTemplate({Key? key}) : super(key : key);

  //final int timerDuration;

  @override
  _TimerTemplateState createState() => _TimerTemplateState();
}

class _TimerTemplateState extends State<TimerTemplate>{
  var countDownDuration;
  Duration duration = Duration.zero;
  Timer? timer;
  late TextEditingController _controller;
  //total time is in seconds and will only add while the timer is
  //actively running
  var totalTime = 0;
  var start; //sets at open of timer
  var end;//sets at close of page
  //initial value for drop down choice of countdown
  String dropdownValue = '1';

  //can set a countup/countdown button(the methods are set here already)
  // but I was having issues with it not starting
  //at the preset time for countdown, or having preset time for countdown
  //default to 0
  bool isCountdown = false;

  @override
  void initState(){
    super.initState();
    //startTimer();
    reset();
    _controller = TextEditingController();
    start = DateTime.now();

  }

  //resets to the set countdown time on cancel of timer
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
    var minutes = int.parse(dropdownValue);
    if(minutes == 1){
      countDownDuration = Duration(minutes: minutes);
      print(countDownDuration);
      isCountdown = true;
    }
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
        end = DateTime.now();
        },
        child: Icon(
          Icons.arrow_circle_left,
        ),//Icon
      ),//leading
    ),//appBar
    backgroundColor: Colors.teal[400],
    body: Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTime(),
          const SizedBox(height: 30),
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
            //buildCountUpCountDownButton(),

            //const SizedBox(height: 24),
            buildImage(),
          ],//children

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

          ],//children

        ),//Row
      ],//children
    );//Column
  }


  Widget buildCountUpCountDownButton(){
    return Align(
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
    );//Align
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
        Text(
          "Choose the number of minutes to :",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),//TextStyle
        ),//Text
        buildDrop(),
        buildStartButton(),
      ],
    );//Row
  }
  Widget buildStartButton(){
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        primary: Colors.white,
        textStyle: const TextStyle(fontSize: 20),
      ),//TextButton.styleFrom
      onPressed: () {
        startTimer();
      },
      child: const Text('START TIME'),
    );//TextButton
  }


  Widget buildDrop(){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
              color: Colors.white, style: BorderStyle.solid, width: 0.95),
        ),
        child: buildDropDownTimeChooser()
    );
  }


  Widget buildDropDownTimeChooser(){
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(
          Icons.arrow_downward,
          color: Colors.white
      ),
      elevation: 20,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      dropdownColor: Colors.teal[900],
      isExpanded: true,
      alignment: Alignment.center,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          var minutes = int.parse(newValue);
          countDownDuration = Duration(minutes: minutes);
          print(countDownDuration);
          isCountdown = true;
        });
      },
      items: <String>['1', '2', '3', '4','5', '6', '7', '8','9', '10', '11', '12','13', '14', '15', '16','17', '18', '19', '20','21', '22', '23', '24','25', '26', '27', '28','29', '30', '31', '32','33', '34', '35', '36','37', '38', '39', '40','41', '42', '43', '44','45', '46', '47', '48','49', '50', '51', '52','53', '54', '55', '56','57', '58', '59', '60',]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );//DropDownButton
  }

}
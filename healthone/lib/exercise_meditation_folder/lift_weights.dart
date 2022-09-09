import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'exercise.dart';
import 'dart:convert';
import 'exercise_data.dart';
import 'db_things.dart';
import '../profile/student.dart';
import '../profile/profile_data.dart';
import '../profile/profile_db_services.dart';
import 'pass_exercise.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'exercise_info_tile.dart';


class WeightLiftingExercise extends StatefulWidget{
  const WeightLiftingExercise({Key? key, required this.exercise, required this.exercisename, required this.exercisetype, required this.metabolicequivalentscore}) : super(key : key);
  final Exercise exercise;
  final String exercisename;
  final String exercisetype;
  final double metabolicequivalentscore;
  @override
  _WeightLiftingExerciseState createState() => _WeightLiftingExerciseState();

}

class _WeightLiftingExerciseState extends State<WeightLiftingExercise>{
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  List<Student>? students;
  var totalReps = 0;
  var weightUsed = 5.0;

  var countDownDuration;
  Duration duration = Duration.zero;
  Timer? timer;
  late TextEditingController _controller;
  var totalTime = 0;
  var start;
  var end;
  var caloriesBurnedPerMinute;
  var totalCaloriesBurned;
  String dropdownValue = '1';

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
                .students[0].username, now, totalTime,
                totalCaloriesBurned, totalReps, weightUsed);
          }
        }
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
          buildButtons(),
        ],//children
      ),//Column
    ),//Center
  );//Scaffold

  Widget buildWeightEntry(){
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        // for below version 2 use this
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      // for version 2 and greater youcan also use this
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter the weight you will be lifting',
      ),//InputDecoration
      onSubmitted: (String value) async {
        await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Thanks!'),
              content: Text(
                  'You will ${widget.exercisename} with "$value" pounds.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    var weight = double.parse(value);
                    weightUsed = weight;
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

    );//TextField
  }


  Widget buildWeightDropDown(){
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
      items: <String>[
        '2.5',
        '5',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        '11',
        '12',
        '13',
        '14',
        '15',
        '16',
        '17',
        '18',
        '19',
        '20',
        '21',
        '22',
        '23',
        '24',
        '25',
        '26',
        '27',
        '28',
        '29',
        '30',
        '31',
        '32',
        '33',
        '34',
        '35',
        '36',
        '37',
        '38',
        '39',
        '40',
        '41',
        '42',
        '43',
        '44',
        '45',
        '46',
        '47',
        '48',
        '49',
        '50',
        '51',
        '52',
        '53',
        '54',
        '55',
        '56',
        '57',
        '58',
        '59',
        '60',
      ]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ); //DropDownButton
  }

  Widget buildImage(){
    return Column(
      children:[
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:
          widget.exercise.exerciseimage == null ?
          Image.network(
            'https://media.giphy.com/media/4bjIKBOWUnVPICCzJc/giphy.gif',
            width: double.infinity,
            height: 200,
            //fit: Boxfit.cover
          )//image.network
              : Image.network(
            '${widget.exercise.exerciseimage}',
            //'https://media.giphy.com/media/YhW0qsOoz8vb37vxFO/giphy.gif',
            width: double.infinity,
            height: 200,
            //fit: Boxfit.cover
          ),//image.network
        ),//ClipRRect
      ],
    );//Column
  }//buildImage


  Widget buildExerciseInfo(){
    return Column(
      children:[
        Text('${widget.exercisename}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,),
        ),//Text
        //const SizedBox(height: 24,),
        Text('${widget.exercisetype}',
          style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 25),
        ),//Text
      ],
    );
  }

  Widget buildRepCard({required int rep}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
            ),//BoxDecoration
            child: Text(
              rep.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 72
              ),//TextStyle
            ),//Text
          ),//Container
        ],//children
      );//Column




  Widget buildButtons(){
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;
    return Column(
      children: [
        buildExerciseInfo(),
        //const SizedBox(height: 24),
        buildImage(),
        buildRepCard(rep: totalReps),
        const SizedBox(height: 24),
        buildIncreaseButton(),
        /*
        Text(
          "Choose the number of reps to do ${widget.exercisename} for:",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),//TextStyle
        ),//Text
        buildDrop(),

         */
        buildWeightEntry(),
      ],
    );//Row
  }


  Widget buildIncreaseButton(){
    return ElevatedButton(
      style: ButtonStyle(
        //color: Colors.teal[700],
        //shape: RoundedRectangleBorder(
            //borderRadius: BorderRadius.all(Radius.circular(16.0))),
      ),
      onPressed: () {
        if(totalReps == 0) {
          startTimer();
        }
        totalReps = totalReps + 1;
        setState(() {});
      },
      child: const Icon(
        Icons.add_circle_rounded,
        size: 30.0
      ),
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
        child: buildWeightDropDown()
    );
  }


  Widget buildDropDownTimeChooser() {
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
      items: <String>[
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        '11',
        '12',
        '13',
        '14',
        '15',
        '16',
        '17',
        '18',
        '19',
        '20',
        '21',
        '22',
        '23',
        '24',
        '25',
        '26',
        '27',
        '28',
        '29',
        '30',
        '31',
        '32',
        '33',
        '34',
        '35',
        '36',
        '37',
        '38',
        '39',
        '40',
        '41',
        '42',
        '43',
        '44',
        '45',
        '46',
        '47',
        '48',
        '49',
        '50',
        '51',
        '52',
        '53',
        '54',
        '55',
        '56',
        '57',
        '58',
        '59',
        '60',
      ]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ); //DropDownButton
  }

}
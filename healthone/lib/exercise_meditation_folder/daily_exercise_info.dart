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
import 'pass_exercise.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


class DailyExerciseInfo extends StatefulWidget{
  const DailyExerciseInfo({Key? key}) : super(key: key);

  @override
  _DailyExerciseInfoState createState() => _DailyExerciseInfoState();
}

class _DailyExerciseInfoState extends State<DailyExerciseInfo>{
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //var currentTime = new DateTime(now.year, now.month, now.day);
  List<PassExercise>? passExercises;
  double caloriesForDay = 0;
  PassExercise? passExercise;

  getExercisesForDay()async{
    passExercises = await DbThings.getExercisesByDay(formattedDate);
    Provider.of<ExerciseData>(context, listen: false).passExercises = passExercises!;
    passExercise = await DbThings.getFavoriteExerciseForDay(formattedDate);
    passExercises?.forEach((item){
      print(item.caloriesburned);
      caloriesForDay = caloriesForDay + item.caloriesburned;
    });
    print(caloriesForDay);
    //print(caloriesForDay);
  }//getExercisesForDay

  @override
  void initState(){
    //print(formattedDate);
    super.initState();
    getExercisesForDay();
  }//initState

  @override
  void dispose(){
    super.dispose();
  }//dispose

  bool _canShowButton = true;

  void hideWidget() {
    setState(() {
      _canShowButton = !_canShowButton;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.teal[900],
      title: Text("Information for ${formattedDate}"),
    ),//AppBar
    backgroundColor: Colors.teal[400],
    body: Center(
      child:
          Column(
        children:[
          buildShowInfoButton(),
          buildCaloriesPrintout(),
          buildLastPerformedExercise(),
          buildFavoriteExercise(),
        ],//children
      ),//Column
    ),//Center
  );//Scaffold


 Widget buildFavoriteExercise(){
   return passExercise?.exercisename == null ?
   Container(
     width: 300.0,
     height: 100.0,
     color: Colors.green,
     margin: EdgeInsets.all(20),
     alignment: Alignment.center,
     child: Text("Favorite exercise today:",
       style: TextStyle(
         color: Colors.white,
         fontSize: 24,
         fontWeight: FontWeight.bold,
       ),//TextStyle
     ),//Text
   )
       :Container(
     width: 300.0,
     height: 100.0,
     color: Colors.green,
     margin: EdgeInsets.all(20),
     alignment: Alignment.center,
     child:Column(
       children:[
         Text(
           "Favorite exercise today:",
           style: TextStyle(
             color: Colors.white,
             fontSize: 24,
             fontWeight: FontWeight.bold,
           ),//TextStyle
         ),//Text
         Text(
           "${passExercise?.exercisename}",
           style: TextStyle(
             color: Colors.white,
             fontSize: 22,
           ),//TextStyle
         ),//Text
       ],//children
     ),//Column
   );//Container
  }

  Widget buildShowInfoButton(){
    return !_canShowButton
        ? const SizedBox.shrink()
        : Align(
      alignment: Alignment.topLeft,
      child: RaisedButton(
        textColor: Colors.white,
        elevation: 7.0,
        color: Colors.blue,
        onPressed: () {
          setState(() => caloriesForDay);
          hideWidget();
        },//onPressed
        child: Text("Reveal daily exercise information"
        ),//Text
      ),//ButtonWidget
    );//Align
  }


  Widget buildLastPerformedExercise(){
    return passExercises?.last.exercisename == null ?
    Container(
      width: 300.0,
      height: 100.0,
      color: Colors.green,
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Text("Most recent exercise: ",
        style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold
        ),//TextStyle
      ),//Text
    )
    :Container(
      width: 300.0,
      height: 100.0,
      color: Colors.green,
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      child:Column(
        children:[
          Text(
            "Most recent exercise: ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
                fontWeight: FontWeight.bold,
            ),//TextStyle
          ),//Text
          Text(
            "${passExercises?.last.exercisename}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),//TextStyle
          ),//Text
        ],//children
      ),//Column
    );//Container
  }
Widget buildCaloriesPrintout(){
  return caloriesForDay == 0 ?
  Container( width: 300.0,
    height: 100.0,
    color: Colors.green,
    margin: EdgeInsets.all(20),
    alignment: Alignment.center,
    child: Text("Calories burned: ",
      style: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold
      ),//TextStyle
       ),//Text
  )
      : Container(
    width: 300.0,
    height: 100.0,
    color: Colors.green,
    margin: EdgeInsets.all(20),
    alignment: Alignment.center,
    child: Column(
    children:[
      Text(
        "Calories burned: ",
        style: TextStyle(
          color: Colors.white,
          fontSize: 28,
            fontWeight: FontWeight.bold
        ),//TextStyle
      ),//Text
      Text(
        "${caloriesForDay}",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),//TextStyle
      ),//Text
    ],
  ),//Column
  );//Container
}

}//class
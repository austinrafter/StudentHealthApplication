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
    //passExercise = await DbThings.getFavoriteExerciseForDay(formattedDate);
    passExercises?.forEach((item){
      caloriesForDay = caloriesForDay + item.caloriesburned;
    });
  }//getExercisesForDay

  @override
  void initState(){
    print(formattedDate);
    super.initState();
    getExercisesForDay();
  }//initState

  @override
  void dispose(){
    super.dispose();
  }//dispose

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.teal[900],
      title: Text("Information for ${formattedDate}"),
    ),//AppBar
    backgroundColor: Colors.teal[400],
    body: Center(
      child: Column(
        children:[
          buildCaloriesPrintout(),
          buildLastPerformedExercise(),
          //buildFavoriteExercise(),
        ],//children
      ),//Column
    ),//Center
  );//Scaffold

/*
 Widget buildFavoriteExercise(){
   return passExercise?.exercisename == null ?
   Container(
     width: 300.0,
     height: 100.0,
     color: Colors.green,
     margin: EdgeInsets.all(20),
     alignment: Alignment.center,
     child: Text("No favorite exercise for today"),
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
           "Favorite exercise for the day: ",
           style: TextStyle(
             color: Colors.white,
             fontSize: 28,
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

 */


  Widget buildLastPerformedExercise(){
    return passExercises?.last.exercisename == null ?
    Container(
      width: 300.0,
      height: 100.0,
      color: Colors.green,
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Text("No recent exercise"),
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
  return Container(
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
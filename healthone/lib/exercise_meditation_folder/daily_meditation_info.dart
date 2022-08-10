import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'exercise.dart';
import 'dart:convert';
import 'exercise_data.dart';
import 'meditation_data.dart';
import 'db_things.dart';
import '../profile/student.dart';
import '../profile/profile_data.dart';
import '../profile/profile_db_services.dart';
import 'pass_meditation.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'meditation_info_tile.dart';



class DailyMeditationInfo extends StatefulWidget{
  const DailyMeditationInfo({Key? key}) : super(key: key);

  @override
  _DailyMeditatioInfoState createState() => _DailyMeditatioInfoState();
}

class _DailyMeditatioInfoState extends State<DailyMeditationInfo>{
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //var currentTime = new DateTime(now.year, now.month, now.day);
  List<PassMeditation>? passMeditations;
  double timeForDay = 0;
  PassMeditation? passMeditation;

  getMeditationsForDay()async{
    passMeditations = await DbThings.getMeditationsByDay(formattedDate);
    Provider.of<MeditationData>(context, listen: false).passMeditations = passMeditations!;
    passMeditation = await DbThings.getFavoriteMeditationForDay(formattedDate);
    passMeditations?.forEach((item){
      print(item.totaltime);
      timeForDay = timeForDay + item.totaltime;
      timeForDay = timeForDay / 60;
    });
    print(timeForDay);
    setState(() {});
    //print(caloriesForDay);
  }//getExercisesForDay

  @override
  void initState(){
    //print(formattedDate);
    super.initState();
    getMeditationsForDay();
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
      title: Text("Meditations for ${formattedDate}"),
    ),//AppBar
    backgroundColor: Colors.teal[400],
    body:
    //Center(
    //child:
    Stack(
      children:[
        buildDailyExerciseTiles(),
        Align(
          alignment: Alignment.center,
          child: Row(
            children:[
              const SizedBox(
                width: 30.0,
                height: 30.0,
              ),
              buildFavoriteExercise(),
              const SizedBox(
                width: 30.0,
                height: 30.0,
              ),
              buildCaloriesPrintout(),
              const SizedBox(
                width: 30.0,
                height: 30.0,
              ),
              buildLastPerformedExercise(),
              const SizedBox(
                width: 30.0,
                height: 30.0,
              ),
            ],//children
          ),//Row
        ),

      ],//children
    ),//Column
    //),//Center
  );//Scaffold


  Widget buildFavoriteExercise(){
    return passMeditation?.meditationname == null ?
    Container(
      width: 300.0,
      height: 100.0,
      color: Colors.green,
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Text("Favorite meditation today:",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),//TextStyle
      ),//Text
    )//Container
        :Align(
      alignment: Alignment.bottomLeft,
      child: RaisedButton(
        onPressed: () => showDialog<String> (

          context: context,
          builder: (ctx) => AlertDialog(
            title:Text(
              "Favorite meditation today:",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold
              ),//TextStyle
            ),//Text
            content: Align(
              //width: 300.0,
              //height: 100.0,
              //color: Colors.green,
              //margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children:[
                  Container(
                    child: Stack(
                      children: [
                        Card(
                          color: Colors.teal[600],
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.teal.shade600,
                            ),//borderside
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),//roundedrectangleborder
                          child: ListTile(
                            title: Text(
                              "${passMeditation?.meditationname}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,),
                            ),//Text
                          ),//ListTile
                        ),//Card
                      ],//stack children
                    ),//Stack
                  ),//Container
                  RaisedButton(
                    //     disabledColor: Colors.red,
                    // disabledTextColor: Colors.black,
                    padding: const EdgeInsets.all(20),
                    textColor: Colors.white,
                    color: Colors.teal[700],
                    onPressed: () {
                      setState(() => {});
                      Navigator.of(ctx).pop();

                    },//onPressed
                    child: const Text('Return to info page'),
                  ),//RaisedButton
                ],
              ),//Column
            ),//Align
          ),//AlertDialog
        ),//onPressed
        child: Text("Fav"),
        color: Colors.teal[700],
        textColor: Colors.white,
        elevation: 5,
      ),//RaisedButton
    );//Align
  }
//"${passExercise?.exercisename}",

  Widget buildDailyExerciseTiles(){
    return passMeditations == null ? Container(
      color: Colors.green,
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text("No exercises for today yet",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),//TextStyle
      ),//Text
    )//Container
        :
    //Container(
    //color: Colors.green,
    //margin: EdgeInsets.all(20),
    //alignment: Alignment.center,
    //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //child:
    Container(
      child: Consumer<MeditationData>(
        builder: (context, passmeditationData, child){
          return ListView.builder(
              itemCount: passmeditationData.passMeditations.length,
              itemBuilder: (context, index) {
                PassMeditation passMeditation1 = passmeditationData.passMeditations[index];
                return MeditationInfoTile(
                    passMeditation: passMeditation1,
                    passmeditationData: passmeditationData
                );//ExerciseTile
              });//itemBuilder

        },//builder
      ),//Consumer
    );//Column
    //);//Container
  }
/*
  Widget buildShowInfoButton(){
    return !_canShowButton
        ? const SizedBox.shrink()
        : Align(
      alignment: Alignment.center,
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

 */


  Widget buildLastPerformedExercise(){
    return passMeditations?.last.meditationname == null ?
    Container(
      width: 300.0,
      height: 100.0,
      color: Colors.green,
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Text("Most recent meditation: ",
        style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold
        ),//TextStyle
      ),//Text
    )
        :Align(
      alignment: Alignment.bottomCenter,
      child: RaisedButton(
        onPressed: () => showDialog<String> (

          context: context,
          builder: (ctx) => AlertDialog(
            title:Text(
              "Most Recent Meditation: ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold
              ),//TextStyle
            ),//Text
            content: Align(
              //width: 300.0,
              //height: 100.0,
              //color: Colors.green,
              //margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children:[
                  Container(
                    child: Stack(
                      children: [
                        Card(
                          color: Colors.teal[600],
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.teal.shade600,
                            ),//borderside
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),//roundedrectangleborder
                          child: ListTile(
                            title: Text(
                              "${passMeditations?.last.meditationname}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,),
                            ),//Text
                          ),//ListTile
                        ),//Card
                      ],//stack children
                    ),//Stack
                  ),//Container
                  RaisedButton(
                    //     disabledColor: Colors.red,
                    // disabledTextColor: Colors.black,
                    padding: const EdgeInsets.all(20),
                    textColor: Colors.white,
                    color: Colors.teal[400],
                    onPressed: () {
                      setState(() => {});
                      Navigator.of(ctx).pop();

                    },//onPressed
                    child: const Text('Return to info page'),
                  ),//RaisedButton
                ],
              ),//Column
            ),//Align
          ),//AlertDialog
        ),//onPressed
        child: Text("Last"),
        color: Colors.teal[700],
        textColor: Colors.white,
        elevation: 5,
      ),//RaisedButton
    );//Align
  }

  // "${passExercises?.last.exercisename}",
  Widget buildCaloriesPrintout(){
    return timeForDay == 0 ?
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
        : Align(
      alignment: Alignment.bottomRight,
      child: RaisedButton(
        onPressed: () => showDialog<String> (

          context: context,
          builder: (ctx) => AlertDialog(
            title:Text(
              "Total Minutes Meditated Today: ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold
              ),//TextStyle
            ),//Text
            content: Align(
              //width: 300.0,
              //height: 100.0,
              //color: Colors.green,
              //margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children:[
                  Container(
                    child: Stack(
                      children: [
                        Card(
                          color: Colors.teal[600],
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.teal.shade600,
                            ),//borderside
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),//roundedrectangleborder
                          child: ListTile(
                            title: Text(
                              "${timeForDay}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,),
                            ),//Text
                          ),//ListTile
                        ),//Card
                      ],//stack children
                    ),//Stack
                  ),//Container
                  RaisedButton(
                    //     disabledColor: Colors.red,
                    // disabledTextColor: Colors.black,
                    padding: const EdgeInsets.all(20),
                    textColor: Colors.white,
                    color: Colors.teal[400],
                    onPressed: () {
                      setState(() => {});
                      Navigator.of(ctx).pop();

                    },//onPressed
                    child: const Text('Return to info page'),
                  ),//RaisedButton
                ],
              ),//Column
            ),//Align
          ),//AlertDialog
        ),//onPressed
        child: Text("Time"),
        color: Colors.teal[700],
        textColor: Colors.white,
        elevation: 5,
      ),//RaisedButton
    );//Align
  }

}//class
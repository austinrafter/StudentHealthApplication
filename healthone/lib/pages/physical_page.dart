import 'package:flutter/material.dart';
import 'exercise_type_page.dart';
import 'nutrition_page.dart';
import 'sleep_page.dart';
import 'meditation_type_page.dart';
import '../exercise_meditation_folder/exercise_types.dart';
import '../exercise_meditation_folder/meditation_types.dart';

import 'physical_page_data.dart';

class PhysicalPage extends StatelessWidget{
 var physicalData = PhysicalData.getData;
  //const PhysicalPage({Key? key}) : super(key: key);

 final pages = [
   ExerciseTypes(),
   MeditationTypes(),
   SleepPage(),
   NutritionPage(),
 ];

 final images =[
   "https://media.giphy.com/media/TF6FLfa5NryGdEJcfY/giphy.gif",
   "https://media.giphy.com/media/iLBQAlaft9NU4/giphy.gif",
   "https://media.giphy.com/media/kIRicSBQwa23pYExQT/giphy.gif",
   "https://media.giphy.com/media/t9811uoqdhx9pQZx3z/giphy.gif",
 ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      appBar: AppBar(
        title: const Text("Physical Health"),
        centerTitle: true,
      ),  

      body: Container(
    padding: EdgeInsets.fromLTRB(10,10,10,0),
    height: 700,
    width: double.maxFinite,

        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: physicalData.length,
                itemBuilder: (context, index){
                  return Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    height: 220,
                    width: double.maxFinite,
                  child: Card(
                    elevation: 5,
                    color: Colors.teal[900],
                      //child: Padding(
                        //padding: EdgeInsets.all(0),
                    //child: Column(
                        //children: [
                          child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  pages[index]),
                            );
                          },
                          child:Card(
                            color: Colors.teal[700],
                            child: Column(
                              children: <Widget>[
                                //Center(
                                  //child:
                                  Container(
                                    alignment: Alignment.center,
                                    child:  PhysicalItemPageName(physicalData[index]),
                                  ),//Container
                                //),//Center
                                Image.network(
                                  '${images[index]}',
                                  width: double.infinity,
                                  height: 120,
                                  //fit: Boxfit.cover
                                )//image.network
                              ],//children
                            ),//Stack
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.teal.shade900,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),//RoundedRectandleBorder
                            elevation: 5,
                            margin: EdgeInsets.all(4.0),
                          ),//child: Card
                        ),//child: GestureDetector
                    //],
                     // ),// child: Padding
                  ),//child: Card
                  );//Container
                },//itemBuilder
              ),//child: ListView.builder
            ),//Expanded

            ],//children: <Widget>
      ),//child: Column

      ),//body: Container

    );//Scaffold
  }//Widget build
}//class


Widget PhysicalItemPageName(data) {
  return Align(
    alignment: Alignment.center,
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '${data['name']}',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 40),
      ),
    ),
  );
}

/*
Widget PhysicalItemPage(data) {
  return Builder(
      MaterialPageRoute(builder: (context) =>  data['page']),
  );
}

 */
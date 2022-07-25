import 'package:flutter/material.dart';
import 'exercise_type_page.dart';
import 'nutrition_page.dart';
import 'sleep_page.dart';
import 'meditation_type_page.dart';

import 'physical_page_data.dart';

class PhysicalPage extends StatelessWidget{
 var physicalData = PhysicalData.getData;
  //const PhysicalPage({Key? key}) : super(key: key);

 final pages = [
   ExerciseTypePage(),
   MeditationTypePage(),
   SleepPage(),
   NutritionPage(),
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
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 2.0,
                          ),
                        ),

                      ),
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  pages[index]),
                            );
                          },
                          child:Card(
                            color: Colors.teal[700],
                            child: Stack(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    color: Colors.teal[700],
                                    width: 200,
                                    height: 500,
                                    alignment: Alignment.center,
                                    child: Container(
                                          child:  PhysicalItemPageName(physicalData[index]),
                                    ),//Column
                                  ),//Container
                                ),//Center
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
                      ),// child: Padding
                    ),//child: Container
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
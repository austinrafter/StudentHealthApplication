import 'dart:ui';

import 'package:flutter/material.dart';

import 'study_timer_page.dart';
import 'classes_page.dart';
import 'study_page_data.dart';

class StudyPage extends StatelessWidget{
  //const StudyPage({Key? key}) : super(key: key);
  var studyPageData = StudyPageData.getData;

  final pages = [
   StudyTimerPage(),
   ClassesPage()
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
      backgroundColor: Colors.blue[500],
      appBar: AppBar(
        title: const Text("Study Habits"),
        centerTitle: true,
      ),  

      body: Container(
      padding: const EdgeInsets.fromLTRB(10,10,10,0),
      height: 700,
      width: double.maxFinite,

        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: studyPageData.length,
                itemBuilder: (context, index){
                  return Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    height: 220,
                    width: double.maxFinite,
                  child: Card(
                    elevation: 5,
                    color: Colors.blue[900],
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
                            color: Colors.blue[700],
                            child: Column(
                              children: <Widget>[
                                //Center(
                                  //child:
                                  Container(
                                    alignment: Alignment.center,
                                    child:  PhysicalItemPageName(studyPageData[index]),
                                  ),//Container
                                //),//Center
                                Image.network(
                                  '${images[index]}',
                                  width: double.infinity,
                                  height: 140,
                                  //fit: Boxfit.cover
                                )//image.network
                              ],//children
                            ),//Stack
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blue.shade900,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),//RoundedRectandleBorder
                            elevation: 5,
                            margin: const EdgeInsets.all(4.0),
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
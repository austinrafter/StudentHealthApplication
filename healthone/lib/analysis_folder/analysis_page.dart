import 'package:flutter/material.dart';
import '../physicalHealthPages/exercise_type_page.dart';
import '../physicalHealthPages/nutrition_page.dart';
import '../physicalHealthPages/sleep_page.dart';
import '../physicalHealthPages/meditation_type_page.dart';
import '../exercise_meditation_folder/exercise_types.dart';
import '../exercise_meditation_folder/meditation_types.dart';
import '../analysis_folder/analysis_page_data.dart';
import '../physicalHealthPages/physical_analysis_page.dart';
import '../physicalHealthPages/exercise_analysis_page.dart';

class AnalysisPage extends StatelessWidget{
  var analysisPageData = AnalysisPageData.getData;
  //const PhysicalPage({Key? key}) : super(key: key);

  final pages = [
    PhysicalAnalysisPage(),
    MeditationTypes(),
    SleepPage(),
  ];

  final images =[
    "https://media.giphy.com/media/3ornjHnlfyrQclXGZq/giphy.gif",
    "https://media.giphy.com/media/Yat5wnwisEV2iXbt4x/giphy.gif",
    "https://media.giphy.com/media/l2SpXaJA67JaSqSxq/giphy.gif",
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      appBar: AppBar(
        title: const Text("Health Analysis"),
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
                itemCount: analysisPageData.length,
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
                                child:  AnalysisItemPageName(analysisPageData[index]),
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


Widget AnalysisItemPageName(data) {
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
import 'package:flutter/material.dart';
import '../pages/exercise_type_page.dart';
import '../pages/nutrition_page.dart';
import '../pages/sleep_page.dart';
import '../pages/meditation_type_page.dart';
import 'meditation_types_data.dart';
import 'daily_meditation_info.dart';
import '../pages/meditation_info_page.dart';

class MeditationTypes extends StatelessWidget{
  var physicalData = MeditationsTypeData.getData;
  //const PhysicalPage({Key? key}) : super(key: key);


  final pages = [
    MeditationTypePage(meditationtype: "Guided"),
    MeditationTypePage(meditationtype: "Unguided"),
    MeditationTypePage(meditationtype: "Mindfulness"),
    MeditationTypePage(meditationtype: "Quiet Relaxation"),
    MeditationInfoPage(),
  ];
  //https://media.giphy.com/media/l4pTpY2fLm9eRGHMQ/giphy.gif

  final images =[
    "https://media.giphy.com/media/105D9aefNvprfG/giphy.gif",
    "https://media.giphy.com/media/l4FGDAx6u3hthMhgI/giphy.gif",
    "https://media.giphy.com/media/CSmmKAum8d1gZqwvmo/giphy.gif",
    "https://media.giphy.com/media/llJJsTA7J627AjNdHP/giphy.gif",
    "https://media.giphy.com/media/l4pTpY2fLm9eRGHMQ/giphy.gif",
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      appBar: AppBar(
        title: const Text("Meditation Types"),
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
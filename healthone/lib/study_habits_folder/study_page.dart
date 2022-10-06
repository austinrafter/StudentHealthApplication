import 'dart:ui';

import 'package:flutter/material.dart';

import 'study_folder/activity_page.dart';
import 'classes_folder/classes_page.dart';
import 'study_folder/study_page_data.dart';

class StudyPage extends StatelessWidget {
  //const StudyPage({Key? key}) : super(key: key);
  var studyPageData = StudyPageData.getData;

  final pages = [const ClassesPage(), const ActivityPage()];

  final images = [
    "https://media.giphy.com/media/yovOUEWBV2R46yrQ0B/giphy.gif",
    "https://media.giphy.com/media/2xnO6tTIYYFE2j3IqQ/giphy.gif",
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: const Text("Study Habits"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        height: 700,
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: studyPageData.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    height: 220,
                    width: double.maxFinite,
                    child: Card(
                      elevation: 5,
                      color: Colors.blue[500],
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => pages[index]),
                          );
                        },
                        child: Card(
                          color: Colors.blue[700],
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                child:
                                    PhysicalItemPageName(studyPageData[index]),
                              ),
                              Image.network(
                                '${images[index]}',
                                width: double.infinity,
                                height: 140,
                              )
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.blue.shade900,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          margin: const EdgeInsets.all(4.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  } //Widget build
} //class

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
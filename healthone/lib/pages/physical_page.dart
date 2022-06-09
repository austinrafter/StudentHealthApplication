import 'package:flutter/material.dart';
import 'exercise_type_page.dart';

import 'physical_page_data.dart';

class PhysicalPage extends StatelessWidget{
 var physicalData = PhysicalData.getData;
  //const PhysicalPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      appBar: AppBar(
        title: const Text("Physical Health Page"),
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
                  return Container(padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                        padding: EdgeInsets.all(7),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  const ExerciseTypePage()),
                            );
                          },
                          child:Card(
                            color: Colors.teal[700],
                            child: Stack(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    width: 200,
                                    height: 500,
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.topCenter,
                                        colors: <Color>[
                                          Colors.black.withAlpha(0),
                                          Colors.black12,
                                          Colors.black45
                                        ],
                                      ),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            PhysicalItemPageName(physicalData[index]),
                                          ]
                                        )
                                      ]


                                    ),


                                  ),
                                ),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  );
                },
              ),
            ),
            /*
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ExerciseTypePage()),
        );
      },
          child:Card(
            color: Colors.teal[700],
              child: Stack(
                children: <Widget>[
                  Center(
                  child: Container(
                    width: 200,
                    height: 500,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.topCenter,
                        colors: <Color>[
                          Colors.black.withAlpha(0),
                          Colors.black12,
                          Colors.black45
                        ],
                      ),
                    ),
                    child: const Text(
                      'Exercise',
                      style: TextStyle(color: Colors.white, fontSize: 40.0),
                    ),


                  ),
      ),
                ],
              ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
      ),
    ),

             */
            ],
      ),

      ),

    );
  }
}


Widget PhysicalItemPageName(data) {
  return Align(
    alignment: Alignment.center,
    child: RichText(
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
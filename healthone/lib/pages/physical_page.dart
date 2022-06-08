import 'package:flutter/material.dart';
import 'exercise_type_page.dart';

class PhysicalPage extends StatelessWidget{
  const PhysicalPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Physical Health Page"),
      ),  

      body: Container(
    padding: EdgeInsets.fromLTRB(10,10,10,0),
    height: 220,
    width: double.maxFinite,

    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ExerciseTypePage()),
        );
      },
          child:Card(
    child: const Text('Exercise'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
      ),
    ),

      ),

    );
  }
}
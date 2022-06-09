import 'package:flutter/material.dart';

class MentalHomePage extends StatefulWidget{
 MentalHomePage({Key? key}) : super(key: key);

  @override
  _MentalHomePageState createState() => _MentalHomePageState();
}

class _MentalHomePageState extends State<MentalHomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.teal[400],
    appBar: AppBar(
      title: const Text("Mental Health Page"),
      backgroundColor: Colors.teal[600],
    ),
    body: Center(
        child: Text(
          "Mental Health Page",
          style: TextStyle(fontSize:50),
        ),
      ),
    );
  }
}


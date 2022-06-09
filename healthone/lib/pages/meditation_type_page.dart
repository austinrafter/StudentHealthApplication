import 'package:flutter/material.dart';

class MeditationTypePage extends StatelessWidget{
  const MeditationTypePage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Text(
            "Meditation Type Page",
            style: TextStyle(fontSize:50),
          ),
        ),
      ),
    );
  }
}
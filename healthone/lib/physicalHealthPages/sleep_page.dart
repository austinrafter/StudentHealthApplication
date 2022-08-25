import 'package:flutter/material.dart';

class SleepPage extends StatelessWidget{
  const SleepPage({Key? key}) : super(key: key);

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
            "Sleep Page",
            style: TextStyle(fontSize:50),
          ),
        ),
      ),
    );
  }
}
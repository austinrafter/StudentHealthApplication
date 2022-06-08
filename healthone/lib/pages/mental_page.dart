import 'package:flutter/material.dart';

class MentalPage extends StatelessWidget{
    const MentalPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
        child: Text(
          "Mental Health Page",
          style: TextStyle(fontSize:50),
        ),
      ),
    );
  }
}
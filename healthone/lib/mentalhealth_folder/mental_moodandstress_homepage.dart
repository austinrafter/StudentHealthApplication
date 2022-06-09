import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthone/mentalhealth_folder/mental_data.dart';
import 'package:healthone/mentalhealth_folder/mentaldb_sevices.dart';
import 'package:healthone/mentalhealth_folder/mood.dart';

class MentalHomePage extends StatefulWidget{
 MentalHomePage({Key? key}) : super(key: key);

  @override
  _MentalHomePageState createState() => _MentalHomePageState();
}

class _MentalHomePageState extends State<MentalHomePage>{

List<Mood>? moods;

getMood()async{

  moods = await DBServices.getMood();
  Provider.of<MentalData>(context, listen: false).moods = moods!;
  setState(() {
    
  });
}

@override
void initState(){
  super.initState();
  getMood();
}


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


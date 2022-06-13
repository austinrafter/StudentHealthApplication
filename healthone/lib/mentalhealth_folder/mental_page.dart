import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthone/mentalhealth_folder/mental_data.dart';
import 'package:healthone/mentalhealth_folder/mental_moodandstress_homepage.dart';

void main() {
  runApp(MentalPage());
}


class MentalPage extends StatelessWidget{
    const MentalPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
    
  @override
  Widget build(BuildContext context){
      return ChangeNotifierProvider<MentalData>(
      create: (context) => MentalData(), // ← create/init your state model
      child: MaterialApp(
      title: "HealthOne",
      theme: ThemeData(
      primaryColor: Colors.teal[400],
      ),
      debugShowCheckedModeBanner: false,
          home: MentalHomePage()
      ),
    );
    // return MaterialApp(
    //   title: "HealthOne",
    //   theme: ThemeData(
    //   primaryColor: Colors.teal[400],
    //   ),
    //   debugShowCheckedModeBanner: false,
    //   home: MentalHomePage(),
    // );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:healthone/mentalhealth_folder/mental_calendar.dart';
import 'package:healthone/mentalhealth_folder/mental_data.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MentalHomePage()));
}

class MentalHomePage extends StatelessWidget {
  const MentalHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return ChangeNotifierProvider<MentalData>(
      create: (context) => MentalData(),
      child: MaterialApp(
        title: "HealthOne",
        theme: ThemeData(
        primaryColor: Colors.teal[400],
        ),
        debugShowCheckedModeBanner: false,
        home: Calendar(),
      ),
    );
    // return MaterialApp(
      // title: "HealthOne",
      // theme: ThemeData(
      //   primaryColor: Colors.teal[400],
      // ),
    //   debugShowCheckedModeBanner: false,
    //   home: Calendar(),
    // );
  }
}
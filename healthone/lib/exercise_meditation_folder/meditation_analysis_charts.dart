import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'db_things.dart';
import 'exercise_tile.dart';
import 'pass_exercise.dart';
import 'meditation_data.dart';
import 'dart:io';
import '../profile/student.dart';
import '../profile/profile_data.dart';
import '../profile/profile_db_services.dart';
import 'timed_meditation_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class PrintMeditationAnalysisCharts extends StatefulWidget {

  @override
  _PrintMeditationAnalysisChartsState createState() => _PrintMeditationAnalysisChartsState();
}

class _PrintMeditationAnalysisChartsState extends State<PrintMeditationAnalysisCharts> {

  List<TimedMeditationChart>? timeMeditationCharts;
  //final DateTime now = new DateTime.now();
  //final DateTime date = new DateTime(now.year, now.month, now.day);
  final String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  getChartsMeditations()async{
    //exercises = await DbThings.getExercises();
    timeMeditationCharts = await DbThings.getMeditationsForChart();
    Provider.of<MeditationData>(context, listen: false).timeMeditationCharts = timeMeditationCharts!;
    setState(() {});
  }

  @override
  void initState(){
    super.initState();
    getChartsMeditations();
  }


  @override
  Widget build(BuildContext context) {
    final List<TimedMeditationChart> defaultData = [
      TimedMeditationChart(minutes: 0, date:formattedDate),
    ];

    List<charts.Series<TimedMeditationChart, String>> timeline = [
      charts.Series(
        id: "Meditation",
        data: timeMeditationCharts?? defaultData,
        domainFn: (TimedMeditationChart timeline, _) => timeline.date,
        measureFn: (TimedMeditationChart timeline, _) => timeline.minutes,
      )
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Flutter Charts Sample")),
      body: Center(
          child: Container(
            height: 400,
            padding: EdgeInsets.all(20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Minutes Meditated Each Day",
                    ),
                    Expanded(
                      child: charts.BarChart(timeline, animate: true),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }

}

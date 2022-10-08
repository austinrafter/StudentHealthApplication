import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'db_things.dart';
import 'exercise_tile.dart';
import 'pass_exercise.dart';
import 'exercise_data.dart';
import 'dart:io';
import '../profile/student.dart';
import '../profile/profile_data.dart';
import '../profile/profile_db_services.dart';
import 'timed_exercise_chart.dart';
import 'weighted_exercise_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class PrintExerciseAnalysisCharts extends StatefulWidget {

  @override
  _PrintExerciseAnalysisChartsState createState() => _PrintExerciseAnalysisChartsState();
}

class _PrintExerciseAnalysisChartsState extends State<PrintExerciseAnalysisCharts> {

  List<TimedExerciseChart>? timedExerciseCharts;
  List<WeightedExerciseChart>? weightedExerciseCharts;
  //final DateTime now = new DateTime.now();
  //final DateTime date = new DateTime(now.year, now.month, now.day);
  final String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  getChartsExercises()async{
    //exercises = await DbThings.getExercises();
    timedExerciseCharts = await DbThings.getExercisesForChart();
    Provider.of<ExerciseData>(context, listen: false).timedExerciseCharts = timedExerciseCharts!;

    weightedExerciseCharts = await DbThings.getWeightedExercisesForChart();
    Provider.of<ExerciseData>(context, listen: false).weightedExerciseCharts = weightedExerciseCharts!;
    setState(() {});
  }

  @override
  void initState(){
    super.initState();
    getChartsExercises();
  }


  @override
  Widget build(BuildContext context) {
    final List<TimedExerciseChart> defaultData = [
      TimedExerciseChart(minutes: 0, date:formattedDate),
    ];

    final List<WeightedExerciseChart> defaultDataWeight = [
      WeightedExerciseChart(exercise: 'none', reps: 0, weight: 0, date:formattedDate),
    ];

    List<charts.Series<TimedExerciseChart, String>> timeline = [
      charts.Series(
        id: "Exercise",
        data: timedExerciseCharts?? defaultData,
        domainFn: (TimedExerciseChart timeline, _) => timeline.date,
        measureFn: (TimedExerciseChart timeline, _) => timeline.minutes,
      )
    ];

    List<charts.Series<WeightedExerciseChart, String>> weightline = [
      charts.Series(
        id: "Weight Exercise",
        data: weightedExerciseCharts?? defaultDataWeight,
        domainFn: (WeightedExerciseChart weightline, _) => weightline.exercise,
        measureFn: (WeightedExerciseChart weightline, _) => weightline.weight,
      )
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Exercise Charts"),centerTitle: true,),
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
              "Minutes Exercised Each Day",
            ),
            Expanded(
              child: charts.BarChart(
                  timeline,
                  animate: true,
                domainAxis: charts.OrdinalAxisSpec(
                  renderSpec: charts.SmallTickRendererSpec(labelRotation: 60),
                ),
              ),
            ),
            Text(
              "Max Weight Lifted By Exercise",
            ),
            Expanded(
               child: charts.BarChart(
                 weightline,
                 animate: true,
                 domainAxis: charts.OrdinalAxisSpec(
                   renderSpec: charts.SmallTickRendererSpec(labelRotation: 60),
                 ),
               ),
            ),
            ],//children
          ),//Column
        ),
      ),
    )
    ),
    );
  }

}

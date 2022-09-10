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

class PrintExerciseAnalysisCharts extends StatefulWidget{
const PrintExerciseAnalysisCharts({Key? key}) : super(key : key);

@override
_PrintExerciseAnalysisChartsState createState() => _PrintExerciseAnalysisChartsState();
}


class _PrintExerciseAnalysisChartsState extends State<PrintExerciseAnalysisCharts>{
  List<TimedExerciseChart>? timedExerciseCharts;

  getChartsExercises()async{
    //exercises = await DbThings.getExercises();
    timedExerciseCharts = await DbThings.getExercisesForChart();
    Provider.of<ExerciseData>(context, listen: false).timedExerciseCharts = timedExerciseCharts!;
    setState(() {});
  }

  @override
  void initState(){
    super.initState();
    getChartsExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Text("exercise charts go here")
    );
  }
  /*
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
            child: Container(
                child: SfCartesianChart(
                    series: <ChartSeries>[
                      // Renders line chart
                      LineSeries<ChartData, int>(
                          dataSource: timedExerciseCharts,
                          xValueMapper: TimedExerciseChart data, _) => data.date,
                          yValueMapper: (TimedExerciseChart data, _) => data.minutes
                      )
                    ]//
                )//SFCartesianChart
            )//Container
        )//Center
    );//Scaffold
  }//build

   */

}
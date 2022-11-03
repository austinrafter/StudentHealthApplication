import 'package:flutter/material.dart';
import 'package:healthone/study_habits_folder/classes_folder/class_data.dart';
import 'package:healthone/study_habits_folder/study_folder/activity.dart';
import 'package:healthone/study_habits_folder/study_folder/activity_data.dart';
import 'package:healthone/study_habits_folder/study_folder/activitydb_service.dart';
import 'package:healthone/study_habits_folder/activity_chart.dart';
import 'package:provider/provider.dart';
import 'classes_folder/classesdb_service.dart';
import 'classes_folder/study_class.dart';
import 'study_habits_global.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;

class StudyHabitsChart extends StatefulWidget {
  @override
  _StudyHabitsChartState createState() => _StudyHabitsChartState();
}

class _StudyHabitsChartState extends State<StudyHabitsChart> {
  List<StudyClass>? classes;
  List<ActivityChart>? activityCharts;
  Map<String, String>? classGrades;
  final String defaultClassCode = "";

  getActivityCharts() async {
    //exercises = await DbThings.getExercises();
    activityCharts = await ActivityDBService.getActvityChartItems();
    Provider.of<ActivityData>(context, listen: false).activityCharts =
        activityCharts!;
    setState(() {});
  }

  getClasses() async {
    classes = await ClassesDBService.getClasses();
    Provider.of<ClassData>(context, listen: false).classes = classes!;
    classes?.forEach((element) {
      print(element);
    });
    setState(() {});
    for (StudyClass c in classes!) {
      classGrades?.putIfAbsent(c.code, () => c.grade);
    }
  }

  @override
  void initState() {
    super.initState();
    getActivityCharts();
    getClasses();
  }

  @override
  Widget build(BuildContext context) {
    final List<ActivityChart> defaultData = [
      ActivityChart(minutes: 0, classCode: defaultClassCode),
    ];

    List<charts.Series<ActivityChart, String>> timeline = [
      charts.Series(
        id: "Meditation",
        data: activityCharts ?? defaultData,
        domainFn: (ActivityChart timeline, _) => timeline.classCode,
        measureFn: (ActivityChart timeline, _) => timeline.minutes,
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Study Habits Charts"),
        centerTitle: true,
      ),
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
                  "Minutes Spent on Each Class",
                ),
                Expanded(
                  child: charts.BarChart(
                    timeline,
                    animate: true,
                    domainAxis: charts.OrdinalAxisSpec(
                      renderSpec:
                          charts.SmallTickRendererSpec(labelRotation: 60),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:healthone/study_habits_folder/classes_folder/class_data.dart';
import 'package:healthone/study_habits_folder/study_folder/activity.dart';
import 'package:healthone/study_habits_folder/study_folder/activity_data.dart';
import 'package:healthone/study_habits_folder/study_folder/activitydb_service.dart';
import 'package:healthone/study_habits_folder/study_habits_chart_page.dart';
import 'package:provider/provider.dart';
import 'classes_folder/classesdb_service.dart';
import 'classes_folder/study_class.dart';
import 'study_habits_global.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;

class StudyHabitsAnalysis extends StatefulWidget {
  @override
  _StudyHabitAnalysisState createState() => _StudyHabitAnalysisState();
}

class _StudyHabitAnalysisState extends State<StudyHabitsAnalysis> {
  List<StudyClass>? classes;
  List<Activity>? activities;

  @override
  void initState() {
    super.initState();
    getActivities();
    getClasses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text("Study Habits Analysis"),
      ),
      backgroundColor: Colors.teal[300],
      body: Column(
        children: [
          buildAnalysisTiles(),
        ],
      ),
      floatingActionButton: buildShowGraphButton(),
    );
  }

  getActivities() async {
    activities = await ActivityDBService.getActivities();
    Provider.of<ActivityData>(context, listen: false).activities = activities!;
    activities?.forEach((element) {
      print(element);
    });
    setState(() {});
  }

  getClasses() async {
    classes = await ClassesDBService.getClasses();
    Provider.of<ClassData>(context, listen: false).classes = classes!;
    classes?.forEach((element) {
      print(element);
    });
    setState(() {});
  }

  Widget buildAnalysisTiles() {
    return classes == null
        ? Container(
            color: Colors.purple[300],
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            alignment: Alignment.center,
            child: const Text(
              "No analysis available.",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          )
        : Consumer<ClassData>(builder: (context, classData, chile) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: classData.classes.length,
              itemBuilder: (context, index) {
                StudyClass curClassData = classData.classes[index];
                return Card(
                  color: Colors.teal[600],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.teal.shade600,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ListTile(
                    title: Text(
                      "${curClassData.code} ${curClassData.name} - ${curClassData.semester}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      "Grade: ${curClassData.point} - ${curClassData.grade}\nTotal time spent on studying: ${Duration(seconds: getTotalDuration(curClassData.code, curClassData.semester))} \n${recommendedStudy(curClassData)}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            );
          });
  }

  Widget buildShowGraphButton() {
    return FloatingActionButton.extended(
      label: Text("Show Graph"),
      icon: Icon(Icons.add),
      hoverColor: Colors.teal[500],
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StudyHabitsChartPage()),
        );
      },
    );
  }

  int getTotalDuration(String classCode, String sem) {
    int total = 0;

    for (Activity a in activities!) {
      if (a.classCode == classCode && a.semester == sem) {
        total += a.duration;
      }
    }
    return total;
  }

  String recommendedStudy(StudyClass curClass) {
    int totalStudyHours = 0;
    int totalClass = 0;

    for (StudyClass c in classes!) {
      totalClass++;
      totalStudyHours += getTotalDuration(c.code, c.semester);
    }

    double averageStudyHours = totalStudyHours / totalClass;
    int totalDuration = getTotalDuration(curClass.code, curClass.semester);

    if (totalDuration <= averageStudyHours && curClass.grade != "A") {
      int timeNeeded = (totalDuration - averageStudyHours.toInt());
      return "ATTENTION NEEDED! Recommended more study";
    } else {
      return "";
    }
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:healthone/study_habits_folder/study_folder/activitydb_service.dart';
import 'package:healthone/study_habits_folder/study_folder/activity.dart';
import 'package:healthone/study_habits_folder/study_folder/study_timer_page.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:healthone/study_habits_folder/study_folder/activity_data.dart';

class ActivityInfo extends StatefulWidget {
  const ActivityInfo({Key? key}) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<ActivityInfo> {
  List<Activity>? activities;
  getActivities() async {
    activities = await ActivityDBService.getActivities();
    Provider.of<ActivityData>(context, listen: false).activities = activities!;
    activities?.forEach((element) {
      print(element);
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getActivities();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text("Study Activities"),
      ),
      backgroundColor: Colors.teal[300],
      body: Column(
        children: [
          buildActivitiesTiles(),
        ],
      ),
      floatingActionButton: buildTimerButton(),
    );
  }

  Widget buildActivitiesTiles() {
    return activities == null
        ? Container(
            color: Colors.purple[300],
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            alignment: Alignment.center,
            child: const Text(
              "No study activities done yet.",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          )
        : Consumer<ActivityData>(builder: (context, activityData, chile) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: activityData.activities.length,
              itemBuilder: (context, index) {
                Activity curActivityData = activityData.activities[index];
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
                      "${curActivityData.classCode} ${curActivityData.semester}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      "Duration: ${Duration(seconds: curActivityData.duration).toString()}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              print("==========Delete Class==========");
                              ActivityData().deleteClass(curActivityData);
                              print("==========Finish deleting==========");
                            },
                            icon: const Icon(Icons.delete)),
                      ],
                    ),
                  ),
                );
              },
            );
          });
  }

  Widget buildTimerButton() {
    return IconButton(
        icon: const Icon(Icons.add_circle),
        color: Colors.white,
        iconSize: 50.0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StudyTimerPage()),
          );
        });
  }
}

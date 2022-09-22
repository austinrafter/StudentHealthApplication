import 'dart:async';
import 'package:flutter/material.dart';
import 'package:healthone/study_habits_folder/classes_folder/classesdb_services.dart';
import 'package:healthone/study_habits_folder/classes_folder/study_class.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:healthone/study_habits_folder/classes_folder/class_data.dart';

class ClassesInfo extends StatefulWidget {
  const ClassesInfo({Key? key}) : super(key: key);

  @override
  _ClassesState createState() => _ClassesState();
}

class _ClassesState extends State<ClassesInfo> {
  List<StudyClass>? classes;

  getClasses() async {
    classes = await ClassesDBService.getClasses();
    Provider.of<ClassData>(context, listen: false).classes = classes!;
    classes?.forEach((element) {
      print(element);
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getClasses();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text("Classes"),
        ),
        backgroundColor: Colors.blue[300],
        body: Center(
          child: buildClassesTiles(),
        ));
  }

  Widget buildClassesTiles() {
    return classes == null
        ? Container(
            color: Colors.purple[300],
            margin: EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: const Text(
              "No classes added yet.",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          )
        : Container(
            child: Consumer<ClassData>(builder: (context, classData, chile) {
              return ListView.builder(
                itemCount: classData.classes.length,
                itemBuilder: (context, index) {
                  StudyClass curClassData = classData.classes[index];
                  return Card(
                    color: Colors.blue[600],
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.blue.shade600,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ListTile(
                      title: Text(
                        "${curClassData.code} ${curClassData.name}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        "${curClassData.point} ${curClassData.grade}",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          );
  }
}

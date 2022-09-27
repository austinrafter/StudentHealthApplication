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
        title: const Text("Classes"),
      ),
      backgroundColor: Colors.blue[300],
      body: Column(
        children: [
          buildClassesTiles(),
          //buildAddClassButton(),
        ],
      ),
      floatingActionButton: buildAddClassButton(false),
    );
  }

  Widget buildClassesTiles() {
    return classes == null
        ? Container(
            color: Colors.purple[300],
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            alignment: Alignment.center,
            child: const Text(
              "No classes added yet.",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          )
        : Consumer<ClassData>(builder: (context, classData, chile) {
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      "${curClassData.semester}\n${curClassData.point} ${curClassData.grade}",
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget buildAddClassButton(bool update) {
    String titleText = "Add Class";
    if (update) titleText = "Update Class";

    return IconButton(
      icon: const Icon(Icons.add_circle),
      color: Colors.white,
      iconSize: 50.0,
      onPressed: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(titleText),
          content: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      const Text("Class code: "),
                      Expanded(
                        child: TextFormField(
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter class code';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Text("Class name: "),
                      Expanded(
                        child: TextFormField(
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter class name';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("Semester: "),
                      Expanded(
                        child: TextFormField(
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter semester';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("Point: "),
                      Expanded(
                        child: TextFormField(
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter point';
                            } else if (double.tryParse(value) == null) {
                              return 'Invalid point';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("Grade: "),
                      Expanded(
                        child: TextFormField(
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter grade';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Process data.
                        }
                      },
                      child: const Text("Submit"),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

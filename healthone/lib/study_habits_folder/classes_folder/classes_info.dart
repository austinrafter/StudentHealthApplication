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
  List<String> semesters = <String>['Spring', 'Summer', 'Fall', 'Winter'];
  List<String> years = <String>[
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023'
  ];
  List<String> grades = <String>['A', 'B', 'C', 'D', 'E', 'F'];

  var classCode = TextEditingController();
  var className = TextEditingController();
  var classPoint = TextEditingController();
  var _classSem = '';
  var _classYear = '';
  var _classGrade = '';

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
        ],
      ),
      floatingActionButton: buildAddClassButton(),
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
                      "${curClassData.semester}\n${curClassData.point} - ${curClassData.grade}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              showClassForm(true, curClassData);
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              print("==========Delete Class==========");
                              ClassData().deleteClass(curClassData);
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget buildAddClassButton() {
    _classSem = semesters.first;
    _classYear = years.first;
    _classGrade = grades.first;

    return IconButton(
        icon: const Icon(Icons.add_circle),
        color: Colors.white,
        iconSize: 50.0,
        onPressed: () {
          showClassForm(
              false,
              StudyClass(
                  id: 1,
                  code: 'code',
                  name: 'name',
                  semester: 'semester',
                  point: 0.0,
                  grade: 'grade'));
        });
  }

  void showClassForm(bool update, StudyClass curClassData) {
    var titleText = 'Add Class';
    if (update) {
      titleText = 'Update Class';
      classCode.text = Text(curClassData.code) as String;
      className.text = Text(curClassData.name) as String;
      classPoint.text = Text(curClassData.point.toString()) as String;
      _classGrade = Text(curClassData.grade) as String;
      _classYear = curClassData.semester.substring(2);
      switch (curClassData.semester.substring(0, 2)) {
        case 'SP':
          _classSem = semesters.first;
          break;
        case 'SU':
          _classSem = semesters.elementAt(1);
          break;
        case 'FA':
          _classSem = semesters.elementAt(2);
          break;
        case 'WI':
          _classSem = semesters.last;
          break;
        default:
          _classSem = semesters.first;
          break;
      }
    }

    showDialog(
        context: context,
        builder: (context) => Scaffold(
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                  child: AlertDialog(
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
                                controller: classCode,
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
                                controller: className,
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
                                child: DropdownButtonFormField(
                              value: _classSem,
                              icon: const Icon(Icons.expand_more),
                              onSaved: (String? value) {
                                setState(() {
                                  _classSem = value!;
                                });
                              },
                              items: semesters.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  _classSem = value!;
                                });
                              },
                            )),
                            Expanded(
                                child: DropdownButtonFormField(
                              value: _classYear,
                              icon: const Icon(Icons.expand_more),
                              onSaved: (String? value) {
                                setState(() {
                                  _classYear = value!;
                                });
                              },
                              items: years.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  _classYear = value!;
                                });
                              },
                            )),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text("Point: "),
                            Expanded(
                              child: TextFormField(
                                controller: classPoint,
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
                                child: DropdownButtonFormField(
                              value: _classGrade,
                              icon: const Icon(Icons.expand_more),
                              onSaved: (String? value) {
                                setState(() {
                                  _classGrade = value!;
                                });
                              },
                              items: grades.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  _classGrade = value!;
                                });
                              },
                            )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print("=========Add Class==========");
                                switch (_classSem) {
                                  case 'Spring':
                                    _classSem = 'SP$_classYear';
                                    break;
                                  case 'Summer':
                                    _classSem = 'SU$_classYear';
                                    break;
                                  case 'Fall':
                                    _classSem = 'FA$_classYear';
                                    break;
                                  case 'Winter':
                                    _classSem = 'WI$_classYear';
                                    break;
                                  default:
                                    _classSem = '';
                                }
                                ClassData().addClass(
                                    classCode.text,
                                    className.text,
                                    _classSem,
                                    double.tryParse(classPoint.text)!,
                                    _classGrade);
                                print("=========Finish Adding==========");
                              }
                            },
                            child: const Text("Submit"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                            },
                            child: const Text("Cancel"),
                          ),
                        ),
                      ],
                    )),
              )),
            ));
  }
}

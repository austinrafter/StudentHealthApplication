import 'package:flutter/material.dart';
import 'package:healthone/study_habits_folder/classes_folder/study_class.dart';
import 'package:provider/provider.dart';
import 'package:healthone/study_habits_folder/classes_folder/class_data.dart';
import 'package:healthone/study_habits_folder/study_folder/study_timer.dart';

void main() {
  runApp(StudyTimerPage());
}

class StudyTimerPage extends StatelessWidget {
  const StudyTimerPage({Key? key}) : super(key: key);
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ClassData>(
        create: (context) => ClassData(),
        child: Container(
          child: StudyTimer(),
        ));
  } //Widget build
} //class
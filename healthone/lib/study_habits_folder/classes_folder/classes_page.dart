import 'package:flutter/material.dart';
import 'package:healthone/study_habits_folder/classes_folder/study_class.dart';
import 'package:provider/provider.dart';
import 'package:healthone/study_habits_folder/classes_folder/class_data.dart';
import 'package:healthone/study_habits_folder/classes_folder/classes_info.dart';

void main() {
  runApp(ClassesPage());
}

class ClassesPage extends StatelessWidget {
  const ClassesPage({Key? key}) : super(key: key);
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ClassData>(
        create: (context) => ClassData(),
        child: Container(
          child: ClassesInfo(),
        ));
  } //Widget build
} //class
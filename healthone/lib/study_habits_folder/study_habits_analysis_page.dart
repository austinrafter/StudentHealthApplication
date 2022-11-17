import 'package:flutter/material.dart';
import 'package:healthone/study_habits_folder/classes_folder/study_class.dart';
import 'package:provider/provider.dart';
import 'package:healthone/study_habits_folder/classes_folder/class_data.dart';
import 'package:healthone/study_habits_folder/study_folder/activity_data.dart';
import 'package:healthone/study_habits_folder/study_habits_analysis.dart';

void main() {
  runApp(StudyHabitsAnalysisPage());
}

class StudyHabitsAnalysisPage extends StatelessWidget {
  const StudyHabitsAnalysisPage({Key? key}) : super(key: key);
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ActivityData>(
            create: (context) => ActivityData()),
        ChangeNotifierProvider<ClassData>(create: (context) => ClassData())
      ],
      child: StudyHabitsAnalysis(),
    );
  } //Widget build
} //class
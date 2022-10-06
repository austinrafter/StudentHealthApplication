import 'package:flutter/material.dart';
import 'package:healthone/study_habits_folder/study_folder/activity.dart';
import 'package:provider/provider.dart';
import 'package:healthone/study_habits_folder/study_folder/activity_data.dart';
import 'package:healthone/study_habits_folder/study_folder/activity_info.dart';

void main() {
  runApp(ActivityPage());
}

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key}) : super(key: key);
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ActivityData>(
        create: (context) => ActivityData(),
        child: Container(
          child: ActivityInfo(),
        ));
  } //Widget build
} //class
import 'package:flutter/material.dart';
import 'package:healthone/study_habits_folder/study_folder/activity_page.dart';
import '../classes_folder/classes_page.dart';
import 'study_timer.dart';

class StudyPageData {
  static final getData = [
    {
      'name': 'Classes',
      'page': ClassesPage(),
    },
    {
      'name': 'Study Activities',
      'page': ActivityPage(),
    },
  ];
}

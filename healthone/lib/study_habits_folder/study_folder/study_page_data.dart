import 'package:flutter/material.dart';
import '../classes_folder/classes_page.dart';
import 'study_timer_page.dart';

class StudyPageData {
  static final getData = [
    {
      'name': 'Classes',
      'page': ClassesPage(),
    },
    {
      'name': 'Study Now',
      'page': StudyTimerPage(),
    },
  ];
}

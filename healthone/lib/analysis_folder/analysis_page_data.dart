import 'package:flutter/material.dart';
import '../physicalHealthPages/exercise_type_page.dart';
import '../physicalHealthPages/meditation_type_page.dart';
import '../physicalHealthPages/sleep_page.dart';
import '../physicalHealthPages/nutrition_page.dart';

class AnalysisPageData {
  static final getData = [
    {
      'name': 'Physical Health',
      'page': ExerciseTypePage(exercisetype: "Aerobic"),

    },
    {
      'name': 'Mental Health',
      'page': MeditationTypePage(meditationtype: "Guided"),
    },
    {
      'name': 'Study Habits',
      'page': SleepPage(),
    },
    {
      'name': 'Nutrition',
      'page': NutritionPage(),
    },
  ];
}
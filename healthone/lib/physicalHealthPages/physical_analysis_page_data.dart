import 'package:flutter/material.dart';
import 'exercise_type_page.dart';
import 'meditation_type_page.dart';
import 'sleep_page.dart';
import 'nutrition_page.dart';

class PhysicalAnalysisData {
  static final getData = [
    {
      'name': 'Exercise Analysis',
      'page': ExerciseTypePage(exercisetype: "Aerobic"),

    },
    {
      'name': 'Meditation Anlysis',
      'page': MeditationTypePage(meditationtype: "Guided"),
    },
    {
      'name': 'Sleep Analysis',
      'page': SleepPage(),
    },
    {
      'name': 'Cross Analysis',
      'page': NutritionPage(),
    },
  ];
}
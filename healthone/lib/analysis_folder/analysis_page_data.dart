import 'package:flutter/material.dart';
import 'package:healthone/mentalhealth_folder/mental_journal.dart';
import '../physicalHealthPages/exercise_type_page.dart';
import '../physicalHealthPages/meditation_type_page.dart';
import '../physicalHealthPages/sleep_page.dart';
import '../physicalHealthPages/nutrition_page.dart';
import '../mentalhealth_folder/mental_analysis.dart';
import '../mentalhealth_folder/mental_journal.dart';
import '../mentalhealth_folder/mental_mood_page.dart';
import '../mentalhealth_folder/mental_health_page.dart';

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
      'name': 'Stress',
      'page': MentalAnalysisPage(),
    },
    {
      'name': 'Mood',
      'page': MentalMoodPage(),
    },
    {
      'name': 'Mental Journal',
      'page': JournalPage(),
    },
    {
      'name': 'Mental Analysis',
      'page': MentalHealthPage(),
    },
    {
      'name': 'Study Habits',
      'page': SleepPage(),
    },
  ];
}
import 'package:flutter/material.dart';
import '../pages/exercise_type_page.dart';

class ExerciseTypesData {
  static final getData = [
    {
      'name': 'Aerobic',
      'page': ExerciseTypePage(exercisetype: 'Aerobic'),

    },
    {
      'name': 'Anaerobic',
      'page': ExerciseTypePage(exercisetype: 'Anaerobic'),
    },
    {
      'name': 'Strength Training',
      'page': ExerciseTypePage(exercisetype: 'Strength Training'),
    },
    {
      'name': 'Flexibility',
      'page': ExerciseTypePage(exercisetype: 'Flexibility'),
    },
  ];
}
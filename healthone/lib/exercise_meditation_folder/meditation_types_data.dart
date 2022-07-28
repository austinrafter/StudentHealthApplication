import 'package:flutter/material.dart';
import '../pages/meditation_type_page.dart';

class MeditationsTypeData {
  static final getData = [
    {
      'name': 'Guided',
      'page': MeditationTypePage(meditationtype: "Guided"),

    },
    {
      'name': 'Unguided',
      'page': MeditationTypePage(meditationtype: "Unguided"),
    },
    {
      'name': 'Mindfulness',
      'page': MeditationTypePage(meditationtype: "Mindfulness"),
    },
    {
      'name': 'Quiet Relaxation',
      'page': MeditationTypePage(meditationtype: "Quiet Relaxation"),
    },
  ];
}
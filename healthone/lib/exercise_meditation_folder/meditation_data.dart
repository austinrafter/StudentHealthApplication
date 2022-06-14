import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'meditation.dart';
import 'db_things.dart';


class MeditationData extends ChangeNotifier{
  List<Meditation> meditations = [];

  void addMeditation(String meditation_name, String meditation_type) async {
    Meditation meditation = await DbThings.addMeditation(meditation_name,meditation_type);
    meditations.add(meditation);
    notifyListeners();
  }


}
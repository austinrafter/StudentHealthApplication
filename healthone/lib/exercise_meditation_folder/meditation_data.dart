import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'meditation.dart';
import 'db_things.dart';


class MeditationData extends ChangeNotifier{
  List<Meditation> meditations = [];

  void addMeditation(String meditationname, String meditationtype) async {
    Meditation meditation = await DbThings.addMeditation(meditationname,meditationtype);
    meditations.add(meditation);
    notifyListeners();
  }


}
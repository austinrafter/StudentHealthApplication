import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'meditation.dart';
import 'db_things.dart';
import '../profile/student.dart';
import 'pass_meditation.dart';
import 'timed_meditation_chart.dart';


class MeditationData extends ChangeNotifier{
  List<Meditation> meditations = [];
  List<Student> students = [];
  List<PassMeditation> passMeditations = [];
  List<TimedMeditationChart> timeMeditationCharts = [];

  void addMeditation(String meditationname, String meditationtype, String audiolink, String imagelink) async {
    Meditation meditation = await DbThings.addMeditation(meditationname,meditationtype, audiolink, imagelink);
    meditations.add(meditation);
    notifyListeners();
  }

  void addStudentMeditating(String meditationname, String username,DateTime dateof, int totaltime, String soundused) async {
    PassMeditation studentMeditating = await DbThings.addStudentMeditating(meditationname,username,dateof, totaltime, soundused);
    passMeditations.add(studentMeditating);
    notifyListeners();
  }


}
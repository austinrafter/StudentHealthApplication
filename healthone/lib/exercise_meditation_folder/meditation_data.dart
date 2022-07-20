import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'meditation.dart';
import 'db_things.dart';
import '../profile/student.dart';
import 'pass_meditation.dart';


class MeditationData extends ChangeNotifier{
  List<Meditation> meditations = [];
  List<Student> students = [];
  List<PassMeditation> passMeditations = [];

  void addMeditation(String meditationname, String meditationtype, String audiolink, String imagelink) async {
    Meditation meditation = await DbThings.addMeditation(meditationname,meditationtype, audiolink, imagelink);
    meditations.add(meditation);
    notifyListeners();
  }

  void addStudentMeditating(String meditationname, String username,DateTime startedat, DateTime endedat, int totaltime, String soundused) async {
    PassMeditation studentMeditating = await DbThings.addStudentMeditating(meditationname,username,startedat,endedat, totaltime, soundused);
    passMeditations.add(studentMeditating);
    notifyListeners();
  }


}
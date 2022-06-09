import 'package:flutter/cupertino.dart';
import 'package:healthone/mentalhealth_folder/mentaldb_sevices.dart';
import 'package:healthone/mentalhealth_folder/mood.dart';

class MentalData extends ChangeNotifier{
List<Mood> moods = [];

  void addMood(String userName, String mood, String month, String day, String year) async{
    Mood m = await DBServices.addMood(userName, mood, month, day, year);
    moods.add(m);
    notifyListeners();
  }

  void updateMood(Mood m){
    notifyListeners();
  }

  void deleteMood(Mood m){
    moods.remove(m);
    notifyListeners();
  }

}
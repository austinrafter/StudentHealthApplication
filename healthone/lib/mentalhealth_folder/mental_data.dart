import 'package:flutter/cupertino.dart';
import 'package:healthone/mentalhealth_folder/mentaldb_sevices.dart';
import 'package:healthone/mentalhealth_folder/mood.dart';

class MentalData extends ChangeNotifier{
List<Mood> moods = [];

  void addStressMood(String userName, String mood, String stress, String month, String day, String year) async{
    print("============addStressMood CALLED UP TO HERE============");
    Mood m = await DBServices.addStressMood(userName, mood, stress, month, day, year);
    moods.add(m);
    print(moods);
    print("============addStressMood THIS IS CALLED============");
    notifyListeners();
  }
  void addMood(String userName, String mood, String month, String day, String year) async{
    print("============addMood CALLED UP TO HERE============");
    Mood m = await DBServices.addMood(userName, mood, month, day, year);
    moods.add(m);
    print(moods);
    print("============addMoodTHIS IS CALLED============");
    notifyListeners();
  }

  void updateMood(Mood m){
    DBServices.updateMood(m.id);
    notifyListeners();
  }

  void deleteMood(Mood m){
    moods.remove(m);
    DBServices.deleteMood(m.id);
    notifyListeners();
  }

}
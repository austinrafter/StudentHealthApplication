import 'package:flutter/cupertino.dart';
import 'package:healthone/study_habits_folder/study_folder/activitydb_service.dart';
import 'package:healthone/study_habits_folder/study_folder/activity.dart';

class ActivityData extends ChangeNotifier {
  List<Activity> Activities = [];

  void addActivity(String classCode, String semester, int duration) async {
    print("============addClass CALLED UP TO HERE============");
    Activity a =
        await ActivityDBService.addActivity(classCode, semester, duration);
    Activities.add(a);
    print(Activities);
    print("============addClass THIS IS CALLED============");
    notifyListeners();
  }

  void updateActivity(int id, String classCode, String semester, int duration) {
    ActivityDBService.updateActivity(id, classCode, semester, duration);
    notifyListeners();
  }

  void deleteClass(Activity a) {
    Activities.remove(a);
    ActivityDBService.deleteActivity(a.id);
    notifyListeners();
  }
}

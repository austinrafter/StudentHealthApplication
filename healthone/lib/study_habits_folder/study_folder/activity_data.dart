import 'package:flutter/cupertino.dart';
import 'package:healthone/study_habits_folder/study_folder/activitydb_service.dart';
import 'package:healthone/study_habits_folder/study_folder/activity.dart';
import 'package:healthone/study_habits_folder/activity_chart.dart';

class ActivityData extends ChangeNotifier {
  List<Activity> activities = [];
  List<ActivityChart> activityCharts = [];

  void addActivity(String classCode, String semester, int duration) async {
    print("============addClass CALLED UP TO HERE============");
    Activity a =
        await ActivityDBService.addActivity(classCode, semester, duration);
    activities.add(a);
    print(activities);
    print("============addClass THIS IS CALLED============");
    notifyListeners();
  }

  void updateActivity(int id, String classCode, String semester, int duration) {
    ActivityDBService.updateActivity(id, classCode, semester, duration);
    notifyListeners();
  }

  void deleteClass(Activity a) {
    activities.remove(a);
    ActivityDBService.deleteActivity(a.id);
    notifyListeners();
  }
}

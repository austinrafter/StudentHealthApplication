import 'dart:convert';

import 'package:healthone/study_habits_folder/study_habits_global.dart';
import 'package:http/http.dart' as http;
import 'package:healthone/study_habits_folder/study_folder/activity.dart';
import 'package:healthone/study_habits_folder/activity_chart.dart';

class ActivityDBService {
  static Future<Activity> addActivity(
      String classCode, String semester, int duration) async {
    Map data = {
      "classCode": classCode,
      "semester": semester,
      "duration": duration,
    };

    var body = json.encode(data);
    var url = Uri.parse(baseUrl + '/activity');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map responseMap = jsonDecode(response.body);
    Activity a = Activity.fromMap(responseMap);
    return a;
  }

  static Future<List<Activity>> getActivities() async {
    var url = Uri.parse(baseUrl + '/activities');

    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    List responseList = jsonDecode(response.body);
    List<Activity> activities = [];

    for (Map activityMap in responseList) {
      Activity activity = Activity.fromMap(activityMap);
      activities.add(activity);
    }
    return activities;
  }

  static Future<http.Response> updateActivity(
      int id, String classCode, String semester, int duration) async {
    Map data = {
      "classCode": classCode,
      "semester": semester,
      "duration": duration,
    };

    var body = json.encode(data);
    var url = Uri.parse(baseUrl + '/activity/$id');

    http.Response response = await http.put(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> deleteActivity(int id) async {
    var url = Uri.parse(baseUrl + '/activity/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }

  static Future<List<ActivityChart>> getActvityChartItems() async {
    var getExerciseUrl = Uri.parse(baseUrl + '/ActivityChartItems');

    http.Response response = await http.get(
      getExerciseUrl,
      headers: headers,
    );
    print(response.body);

    List responseList = jsonDecode(response.body);
    //Map<String, dynamic> responseList = new Map<String, dynamic>.from(json.decode(response['body']));
    List<ActivityChart> activityChartsList = [];
    for (Map activityChartMap in responseList) {
      ActivityChart activityChart = ActivityChart.fromMap(activityChartMap);
      activityChartsList.add(activityChart);
    }
    for (ActivityChart activityChart in activityChartsList) {
      print(activityChart);
    }
    return activityChartsList;
  }
}

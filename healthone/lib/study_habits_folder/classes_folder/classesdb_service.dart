import 'dart:convert';

import 'package:healthone/study_habits_folder/study_habits_global.dart';
import 'package:http/http.dart' as http;
import 'package:healthone/study_habits_folder/classes_folder/study_class.dart';

class ClassesDBService {
  static Future<StudyClass> addClass(String code, String name, String semester,
      double point, String grade) async {
    Map data = {
      "code": code,
      "name": name,
      "semester": semester,
      "point": point,
      "grade": grade,
    };

    var body = json.encode(data);
    var url = Uri.parse(baseUrl + '/class');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map responseMap = jsonDecode(response.body);
    StudyClass c = StudyClass.fromMap(responseMap);
    return c;
  }

  static Future<List<StudyClass>> getClasses() async {
    var url = Uri.parse(baseUrl + '/classes');

    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    List responseList = jsonDecode(response.body);
    List<StudyClass> classes = [];

    for (Map classMap in responseList) {
      StudyClass studyClass = StudyClass.fromMap(classMap);
      classes.add(studyClass);
    }
    return classes;
  }

  static Future<http.Response> updateClass(int id, String code, String name,
      String semester, double point, String grade) async {
    Map data = {
      "code": code,
      "name": name,
      "semester": semester,
      "point": point,
      "grade": grade,
    };

    var body = json.encode(data);
    var url = Uri.parse(baseUrl + '/class/$id');

    http.Response response = await http.put(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> deleteClass(int id) async {
    var url = Uri.parse(baseUrl + '/class/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }
}

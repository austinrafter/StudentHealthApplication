import 'dart:convert';
import 'package:http/http.dart' as http;
import 'exercise.dart';
import 'global_vars.dart';
import 'meditation.dart';
import '../profile/student.dart';
import 'student_exercising.dart';


class DbThings{
  static Future<Exercise> addExercise(String exercise_name, String exercise_type, double metabolic_equivalent_score) async{
    Map data = {
      "exercise_name" : exercise_name,
      "exercise_type" : exercise_type,
      "metabolic_equivalent_score" : metabolic_equivalent_score,
    };

    var body = json.encode(data);
    var addExerciseUrl = Uri.parse(exerciseUrl + '/add');
    
    http.Response response = await http.post(
    addExerciseUrl,
    headers: headers,
    body: body
    );
    print(response.body);

    Map responseMap = jsonDecode(response.body);
    print("gets here");
    print(responseMap);
    Exercise exercise = Exercise.fromMap(responseMap);

    return exercise;
  }

  static Future<List<Exercise>> getExercises() async{
    var getExerciseUrl = Uri.parse(exerciseUrl + '/getExercises');

    http.Response response = await http.get(
      getExerciseUrl,
      headers: headers,
    );

    List responseList = jsonDecode(response.body);
    //Map<String, dynamic> responseList = new Map<String, dynamic>.from(json.decode(response['body']));
    List<Exercise> exercises = [];
    for(Map exerciseMap in responseList){
      Exercise exercise = Exercise.fromMap(exerciseMap);
      exercises.add(exercise);
    }
    return exercises;
  }

  static Future<List<Meditation>> getMeditations() async{
    var getMeditationsUrl = Uri.parse(meditationUrl + '/getMeditations');

    http.Response response = await http.get(
      getMeditationsUrl,
      headers: headers,
    );

    List responseList = jsonDecode(response.body);
    //Map<String, dynamic> responseList = new Map<String, dynamic>.from(json.decode(response['body']));
    List<Meditation> meditations = [];
    for(Map meditationMap in responseList){
      Meditation meditation = Meditation.fromMap(meditationMap);
      meditations.add(meditation);
    }
    return meditations;
  }

  static Future<Meditation> addMeditation(String meditation_name, String meditation_type) async{
    Map data = {
      "meditation_name" : meditation_name,
      "meditation_type" : meditation_type,
    };

    var body = json.encode(data);
    var addMeditationUrl = Uri.parse(meditationUrl + '/addmeditation');

    http.Response response = await http.post(
        addMeditationUrl,
        headers: headers,
        body: body
    );
    print(response.body);

    Map responseMap = jsonDecode(response.body);
    Meditation meditation = Meditation.fromMap(responseMap);

    return meditation;
  }

  static Future<StudentExercising> addStudentExercising(Exercise exercise, Student student, DateTime started_at, DateTime ended_at) async{
    Map data = {
      "exercise" : exercise,
      "student" : student,
      "started_at" : started_at,
      "ended_at": ended_at
    };

    var body = json.encode(data);
    var addExerciseUrl = Uri.parse(exerciseUrl + '/addtouser');

    http.Response response = await http.post(
        addExerciseUrl,
        headers: headers,
        body: body
    );
    print(response.body);

    Map responseMap = jsonDecode(response.body);
    StudentExercising studentExercising = StudentExercising.fromMap(responseMap);

    return studentExercising;
  }

  static Future<http.Response> updateStudentExercising(int id) async {
    var url = Uri.parse(exerciseUrl + '/update/$id');
    http.Response response = await http.put(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }

}
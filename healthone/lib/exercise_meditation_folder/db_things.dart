import 'dart:convert';
import 'package:http/http.dart' as http;
import 'exercise.dart';
import 'global_vars.dart';
import 'meditation.dart';
import '../profile/student.dart';
import 'student_exercising.dart';
import 'pass_exercise.dart';
import 'pass_meditation.dart';

class DbThings{
  static Future<Exercise> addExercise(String exercisename, String exercisetype, double metabolicequivalentscore) async{
    Map data = {
      "exercisename" : exercisename,
      "exercisetype" : exercisetype,
      "metabolicequivalentscore" : metabolicequivalentscore,
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

  static Future<Meditation> addMeditation(String meditationname, String meditationtype, String audiolink, String imagelink) async{
    Map data = {
      "meditationname" : meditationname,
      "meditationtype" : meditationtype,
      "audiolink" : audiolink,
      "imagelink" : imagelink,
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

  static Future<PassExercise> addStudentExercising(String exercisename, String username, DateTime dateof, int totaltime, double caloriesburned) async{
    Map data = {
      "exercisename" : exercisename,
      "username" : username,
      "dateof" : dateof.toIso8601String(),
      "totaltime": totaltime,
      "caloriesburned" : caloriesburned
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
    PassExercise studentExercising = PassExercise.fromMap(responseMap);

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

  static Future<List<Student>> getStudents() async{
    var getStudentsUrl = Uri.parse(exerciseUrl + '/getStudents');

    http.Response response = await http.get(
      getStudentsUrl,
      headers: headers,
    );

    List responseList = jsonDecode(response.body);
    //Map<String, dynamic> responseList = new Map<String, dynamic>.from(json.decode(response['body']));
    List<Student> students = [];
    for(Map studentMap in responseList){
      Student student = Student.fromMap(studentMap);
      students.add(student);
    }
    return students;
  }

  static Future<PassMeditation> addStudentMeditating(String meditationname, String username, DateTime dateof, int totaltime, String soundused) async{
    Map data = {
      "meditationname" : meditationname,
      "username" : username,
      "dateof" : dateof.toIso8601String(),
      "totaltime": totaltime,
      "soundused" : soundused
    };

    var body = json.encode(data);
    var addMeditationUrl = Uri.parse(meditationUrl + '/addmeditationtouser');

    http.Response response = await http.post(
        addMeditationUrl,
        headers: headers,
        body: body
    );
    print(response.body);

    Map responseMap = jsonDecode(response.body);
    PassMeditation studentMeditating = PassMeditation.fromMap(responseMap);

    return studentMeditating;
  }

}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'exercise.dart';
import 'global_vars.dart';
import 'meditation.dart';
import '../profile/student.dart';
import 'student_exercising.dart';
import 'pass_exercise.dart';
import 'pass_meditation.dart';
import 'timed_exercise_chart.dart';
import 'timed_meditation_chart.dart';
import 'weighted_exercise_chart.dart';

class DbThings{
  static Future<Exercise> addExercise(String exercisename, String exercisetype, double metabolicequivalentscore, String exerciseimage) async{
    Map data = {
      "exercisename" : exercisename,
      "exercisetype" : exercisetype,
      "metabolicequivalentscore" : metabolicequivalentscore,
      "exerciseimage" : exerciseimage
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

  static Future<PassExercise> addStudentExercising(String exercisename, String username, DateTime dateof, int totaltime, double caloriesburned, int reps, double weightrepped) async{
    Map data = {
      "exercisename" : exercisename,
      "username" : username,
      "dateof" : dateof.toIso8601String(),
      "totaltime": totaltime,
      "caloriesburned" : caloriesburned,
      "reps" : reps,
      "weightrepped" : weightrepped
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

  static Future<List<Student>> getStudentIfPresent(String username) async{
    Map data = {
      "username" : username,
      "email" : "email",
      "school" : "school",
      "weight" : 0.0,
    };

    var body = json.encode(data);
    var addStudentUrl = Uri.parse(exerciseUrl + '/getStudentIfPresent');

    http.Response response = await http.post(
      addStudentUrl,
      headers: headers,
      body: body,
    );
    print(response.body);
    List responseList = jsonDecode(response.body);
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

  static Future<List<Exercise>> getExercisesByType(String exercisetype) async{

    Map data = {
      "exercisename" : "exercise",
      "exercisetype" : exercisetype,
      "metabolicequivalentscore" : 1,
      "exerciseimage" : "image"
    };

    var body = json.encode(data);
    var addExerciseUrl = Uri.parse(exerciseUrl + '/getExercisesByType');

    http.Response response = await http.post(
        addExerciseUrl,
        headers: headers,
        body: body
    );
    print(response.body);

    List responseList = jsonDecode(response.body);
    //Map<String, dynamic> responseList = new Map<String, dynamic>.from(json.decode(response['body']));
    List<Exercise> exercises = [];
    for(Map exerciseMap in responseList){
      Exercise exercise = Exercise.fromMap(exerciseMap);
      exercises.add(exercise);
    }
    return exercises;
  }


  static Future<List<Meditation>> getMeditationsByType(String meditationtype) async{
    Map data = {
      "meditationname" : "meditation",
      "meditationtype" : meditationtype + " meditation",
      "audiolink" : "link",
      "imagelink" : "link",
    };

    var body = json.encode(data);
    var addExerciseUrl = Uri.parse(meditationUrl + '/getMeditationsByType');

    http.Response response = await http.post(
        addExerciseUrl,
        headers: headers,
        body: body
    );
    print(response.body);

    List responseList = jsonDecode(response.body);
    //Map<String, dynamic> responseList = new Map<String, dynamic>.from(json.decode(response['body']));
    List<Meditation> meditations = [];
    for(Map meditationMap in responseList){
      Meditation meditation = Meditation.fromMap(meditationMap);
      meditations.add(meditation);
    }
    return meditations;
  }


  static Future<List<PassExercise>> getExercisesByDay(String dateof) async{

    Map data = {
      "exercisename" : "exercisename",
      "username" : "username",
      "dateof" : dateof,
      "totaltime": 0,
      "caloriesburned" : 0,
      "reps" : 0,
      "weightrepped" : 0
    };


    var body = json.encode(data);
    var addExerciseUrl = Uri.parse(exerciseUrl + '/getExercisesByDate');

    http.Response response = await http.post(
        addExerciseUrl,
        headers: headers,
        body: body
    );
    print(response.body);

    List responseList = jsonDecode(response.body);
    //Map<String, dynamic> responseList = new Map<String, dynamic>.from(json.decode(response['body']));
    List<PassExercise> passExercises = [];
    for(Map passExerciseMap in responseList){
      PassExercise passExercise = PassExercise.fromMap(passExerciseMap);
      passExercises.add(passExercise);
    }
    return passExercises;
  }

  static Future<PassExercise> getFavoriteExerciseForDay(String dateof) async{
    Map data = {
      "exercisename" : "exercisename",
      "username" : "username",
      "dateof" : dateof,
      "totaltime": 0,
      "caloriesburned" : 0,
      "reps" : 0,
      "weightrepped" : 0
    };

    var body = json.encode(data);
    var addExerciseUrl = Uri.parse(exerciseUrl + '/getFavoriteExerciseForDate');

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

  static Future<List<PassMeditation>> getMeditationsByDay(String dateof) async{

    Map data = {
      "meditationname" : "meditationname",
      "username" : "username" + dateof,
      "dateof" : dateof,
      "totaltime": 1,
      "soundused" : "sound"
    };


    var body = json.encode(data);
    var addExerciseUrl = Uri.parse(meditationUrl + '/getMeditationsByDate');

    http.Response response = await http.post(
        addExerciseUrl,
        headers: headers,
        body: body
    );
    print(response.body);

    List responseList = jsonDecode(response.body);
    //Map<String, dynamic> responseList = new Map<String, dynamic>.from(json.decode(response['body']));
    List<PassMeditation> passMeditations = [];
    for(Map passExerciseMap in responseList){
      PassMeditation passMeditation = PassMeditation.fromMap(passExerciseMap);
      passMeditations.add(passMeditation);
    }
    return passMeditations;
  }

  static Future<PassMeditation> getFavoriteMeditationForDay(String dateof) async{
    Map data = {
      "meditationname" : "meditationname",
      "username" : "username" + dateof,
      "dateof" : dateof,
      "totaltime": 1,
      "soundused" : "sound"
    };

    var body = json.encode(data);
    var addExerciseUrl = Uri.parse(meditationUrl + '/getFavoriteMeditationForDate');

    http.Response response = await http.post(
        addExerciseUrl,
        headers: headers,
        body: body
    );
    print(response.body);

    Map responseMap = jsonDecode(response.body);
    PassMeditation passMeditation = PassMeditation.fromMap(responseMap);

    return passMeditation;
  }

  static Future<List<TimedExerciseChart>> getExercisesForChart() async{
    var getExerciseUrl = Uri.parse(exerciseUrl + '/getUserTimedExercises');

    http.Response response = await http.get(
      getExerciseUrl,
      headers: headers,
    );
    print(response.body);

    List responseList = jsonDecode(response.body);
    //Map<String, dynamic> responseList = new Map<String, dynamic>.from(json.decode(response['body']));
    List<TimedExerciseChart> timedExerciseCharts = [];
    for(Map timedExerciseChartMap in responseList){
      TimedExerciseChart timedExerciseChart = TimedExerciseChart.fromMap(timedExerciseChartMap);
      timedExerciseCharts.add(timedExerciseChart);
    }
    return timedExerciseCharts;
  }


  static Future<List<TimedMeditationChart>> getMeditationsForChart() async{
    var getExerciseUrl = Uri.parse(meditationUrl + '/getUserTimedMeditation');

    http.Response response = await http.get(
      getExerciseUrl,
      headers: headers,
    );
    print(response.body);

    List responseList = jsonDecode(response.body);
    //Map<String, dynamic> responseList = new Map<String, dynamic>.from(json.decode(response['body']));
    List<TimedMeditationChart> timedMeditationCharts = [];
    for(Map timedMeditationChartMap in responseList){
      TimedMeditationChart timedMeditationChart = TimedMeditationChart.fromMap(timedMeditationChartMap);
      timedMeditationCharts.add(timedMeditationChart);
    }
    return timedMeditationCharts;
  }

  static Future<List<WeightedExerciseChart>> getWeightedExercisesForChart() async{
    var getExerciseUrl = Uri.parse(exerciseUrl + '/getUserWeightedExercises');

    http.Response response = await http.get(
      getExerciseUrl,
      headers: headers,
    );
    print(response.body);

    List responseList = jsonDecode(response.body);
    //Map<String, dynamic> responseList = new Map<String, dynamic>.from(json.decode(response['body']));
    List<WeightedExerciseChart> weightedExerciseCharts = [];
    for(Map weightedExerciseChartMap in responseList){
      WeightedExerciseChart weightedExerciseChart = WeightedExerciseChart.fromMap(weightedExerciseChartMap);
      weightedExerciseCharts.add(weightedExerciseChart);
    }
    return weightedExerciseCharts;
  }
}
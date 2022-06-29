import 'dart:convert';
import 'package:http/http.dart' as http;
import 'student.dart';
import '../exercise_meditation_folder/global_vars.dart';


class ProfileDb{
  static Future<Student> addStudent(String user_name, String email, String school, double weight) async{
    Map data = {
      "user_name" : user_name,
      "email" : email,
      "school" : school,
      "weight" : weight,
    };

    var body = json.encode(data);
    var addStudentUrl = Uri.parse(exerciseUrl + '/addStudent');

    http.Response response = await http.post(
        addStudentUrl,
        headers: headers,
        body: body
    );
    print(response.body);

    Map responseMap = jsonDecode(response.body);
    Student student = Student.fromMap(responseMap);

    return student;
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


}
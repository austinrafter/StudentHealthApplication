import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'student.dart';
import 'profile_db_services.dart';

class ProfileData extends ChangeNotifier{
  List<Student> students = [];

  void addStudent(String user_name, String email,String school, double weight) async {
    Student student = await ProfileDb.addStudent(user_name,email,school,weight);
    students.add(student);
    notifyListeners();
  }


}
import 'package:flutter/cupertino.dart';
import 'package:healthone/study_habits_folder/classes_folder/classesdb_services.dart';
import 'package:healthone/study_habits_folder/classes_folder/study_class.dart';

class ClassData extends ChangeNotifier {
  List<StudyClass> classes = [];

  void addClass(String code, String name, double point, String grade) async {
    print("============addClass CALLED UP TO HERE============");
    StudyClass c = await ClassesDBService.addClass(code, name, point, grade);
    classes.add(c);
    print(classes);
    print("============addClass THIS IS CALLED============");
    notifyListeners();
  }

  void updateClass(StudyClass c) {
    ClassesDBService.updateClass(c.id);
    notifyListeners();
  }

  void deleteClass(StudyClass c) {
    classes.remove(c);
    ClassesDBService.deleteClass(c.id);
    notifyListeners();
  }
}

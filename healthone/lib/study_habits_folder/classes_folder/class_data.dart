import 'package:flutter/cupertino.dart';
import 'package:healthone/study_habits_folder/classes_folder/classesdb_service.dart';
import 'package:healthone/study_habits_folder/classes_folder/study_class.dart';

class ClassData extends ChangeNotifier {
  List<StudyClass> classes = [];

  void addClass(String code, String name, String semester, double point,
      String grade) async {
    print("============addClass CALLED UP TO HERE============");
    StudyClass c =
        await ClassesDBService.addClass(code, name, semester, point, grade);
    classes.add(c);
    print(classes);
    print("============addClass THIS IS CALLED============");
    notifyListeners();
  }

  void updateClass(int id, String code, String name, String semester,
      double point, String grade) {
    ClassesDBService.updateClass(id, code, name, semester, point, grade);
    notifyListeners();
  }

  void deleteClass(StudyClass c) {
    classes.remove(c);
    ClassesDBService.deleteClass(c.id);
    notifyListeners();
  }
}

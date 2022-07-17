import '../profile/student.dart';
import 'exercise.dart';

class StudentExercising {
  final int studentexercisingid;
  final Exercise exercise;
  final Student student;
  final DateTime startedat;
  DateTime endedat;
  final int totaltime;
  final double caloriesburned;

  StudentExercising({
    required this.studentexercisingid,
    required this.exercise,
    required this.student,
    required this.startedat,
    required this.endedat,
    required this.totaltime,
    required this.caloriesburned,
  });

  factory StudentExercising.fromMap(Map studentExercisingMap){
    return StudentExercising(
      studentexercisingid: studentExercisingMap['studentexercisingid'],
      exercise: studentExercisingMap['exercise'],
      student: studentExercisingMap['student'],
      startedat: studentExercisingMap['startedat'],
      endedat: studentExercisingMap['endedat'],
      totaltime: studentExercisingMap['totaltime'],
      caloriesburned: studentExercisingMap['caloriesburned'],
    );
  }

  void updateEndTime(){
    endedat = DateTime.now();
  }
}
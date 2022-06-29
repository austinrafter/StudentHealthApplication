import '../profile/student.dart';
import 'exercise.dart';

class StudentExercising {
  final int student_exercising_id;
  final Exercise exercise;
  final Student student;
  final DateTime started_at;
  DateTime ended_at;
  final double calories_burned;

  StudentExercising({
    required this.student_exercising_id,
    required this.exercise,
    required this.student,
    required this.started_at,
    required this.ended_at,
    required this.calories_burned,
  });

  factory StudentExercising.fromMap(Map studentExercisingMap){
    return StudentExercising(
      student_exercising_id: studentExercisingMap['student_exercising_id'],
      exercise: studentExercisingMap['exercise'],
      student: studentExercisingMap['student'],
      started_at: studentExercisingMap['started_at'],
      ended_at: studentExercisingMap['ended_at'],
      calories_burned: studentExercisingMap['calories_burned'],
    );
  }

  void updateEndTime(){
    ended_at = DateTime.now();
  }
}
class PassExercise {
  final int passexerciseid;
  final String exercisename;
  final String username;
  final String dateof;
  final int totaltime;
  final double caloriesburned;
  final int reps;
  final double weightrepped;

  PassExercise({
    required this.passexerciseid,
    required this.exercisename,
    required this.username,
    required this.dateof,
    required this.totaltime,
    required this.caloriesburned,
    required this.reps,
    required this.weightrepped,
  });

  factory PassExercise.fromMap(Map studentExercisingMap){
    return PassExercise(
      passexerciseid: studentExercisingMap['passexerciseid'],
      exercisename: studentExercisingMap['exercisename'],
      username: studentExercisingMap['username'],
      dateof: studentExercisingMap['dateof'],
      totaltime: studentExercisingMap['totaltime'],
      caloriesburned: studentExercisingMap['caloriesburned'],
      reps: studentExercisingMap['reps'],
      weightrepped: studentExercisingMap['weightrepped'],
    );
  }

}//class
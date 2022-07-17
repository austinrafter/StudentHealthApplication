class PassExercise {
  final int passexerciseid;
  final String exercisename;
  final String username;
  final String startedat;
  final String endedat;
  final int totaltime;
  final double caloriesburned;

  PassExercise({
    required this.passexerciseid,
    required this.exercisename,
    required this.username,
    required this.startedat,
    required this.endedat,
    required this.totaltime,
    required this.caloriesburned,
  });

  factory PassExercise.fromMap(Map studentExercisingMap){
    return PassExercise(
      passexerciseid: studentExercisingMap['passexerciseid'],
      exercisename: studentExercisingMap['exercisename'],
      username: studentExercisingMap['username'],
      startedat: studentExercisingMap['startedat'],
      endedat: studentExercisingMap['endedat'],
      totaltime: studentExercisingMap['totaltime'],
      caloriesburned: studentExercisingMap['caloriesburned'],
    );
  }

}//class
class Exercise {
  final int exerciseid;
  final String exercisename;
  final String exercisetype;
  final double metabolicequivalentscore;
  final String exerciseimage;

  Exercise({
    required this.exerciseid,
    required this.exercisename,
    required this.exercisetype,
    required this.metabolicequivalentscore,
    required this.exerciseimage,
  });

  factory Exercise.fromMap(Map exerciseMap){
    return Exercise(
      exerciseid: exerciseMap['exerciseid'],
      exercisename: exerciseMap['exercisename'],
      exercisetype: exerciseMap['exercisetype'],
      metabolicequivalentscore: exerciseMap['metabolicequivalentscore'],
      exerciseimage: exerciseMap['exerciseimage'],
    );
  }
}
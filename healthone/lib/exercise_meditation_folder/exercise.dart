class Exercise {
  final int exerciseId;
  final String exerciseName;
  final String exerciseType;
  final double metabolicEquivalentScore;

  Exercise({
    required this.exerciseId,
    required this.exerciseName,
    required this.exerciseType,
    required this.metabolicEquivalentScore,
  });

  factory Exercise.fromMap(Map exerciseMap){
    return Exercise(
      exerciseId: exerciseMap['exerciseId'],
      exerciseName: exerciseMap['exerciseName'],
      exerciseType: exerciseMap['exerciseType'],
      metabolicEquivalentScore: exerciseMap['metabolicEquivalentScore'],
    );
  }
}
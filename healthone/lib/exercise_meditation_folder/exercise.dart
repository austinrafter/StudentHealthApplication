class Exercise {
  final int exercise_id;
  final String exercise_name;
  final String exercise_type;
  final double metabolic_equivalent_score;

  Exercise({
    required this.exercise_id,
    required this.exercise_name,
    required this.exercise_type,
    required this.metabolic_equivalent_score,
  });

  factory Exercise.fromMap(Map exerciseMap){
    return Exercise(
      exercise_id: exerciseMap['exercise_id'],
      exercise_name: exerciseMap['exercise_name'],
      exercise_type: exerciseMap['exercise_type'],
      metabolic_equivalent_score: exerciseMap['metabolic_equivalent_score'],
    );
  }
}
class WeightedExerciseChart {
  final String exercise;
  final int reps;
  final double weight;
  final String date;

  WeightedExerciseChart({
    required this.exercise,
    required this.reps,
    required this.weight,
    required this.date,
  });

  factory WeightedExerciseChart.fromMap(Map weightedExerciseChartMap){
    return WeightedExerciseChart(
      exercise: weightedExerciseChartMap['exercise'],
      reps: weightedExerciseChartMap['reps'],
      weight: weightedExerciseChartMap['weight'],
      date: weightedExerciseChartMap['date'],
    );
  }
}
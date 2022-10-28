class TimedExerciseChart {
  final double minutes;
  final String date;
  final double calories;

  TimedExerciseChart({
    required this.minutes,
    required this.date,
    required this.calories
  });

  factory TimedExerciseChart.fromMap(Map timedExerciseChartMap){
    return TimedExerciseChart(
      minutes: timedExerciseChartMap['minutes'],
      date: timedExerciseChartMap['date'],
      calories: timedExerciseChartMap['calories'],
    );
  }
}
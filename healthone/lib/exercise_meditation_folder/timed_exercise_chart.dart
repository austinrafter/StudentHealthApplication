class TimedExerciseChart {
  final double minutes;
  final String date;

  TimedExerciseChart({
    required this.minutes,
    required this.date,
  });

  factory TimedExerciseChart.fromMap(Map timedExerciseChartMap){
    return TimedExerciseChart(
      minutes: timedExerciseChartMap['minutes'],
      date: timedExerciseChartMap['date'],
    );
  }
}
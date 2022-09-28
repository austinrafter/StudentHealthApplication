class TimedMeditationChart {
  final double minutes;
  final String date;

  TimedMeditationChart({
    required this.minutes,
    required this.date,
  });

  factory TimedMeditationChart.fromMap(Map timeMeditationChartMap){
    return TimedMeditationChart(
      minutes: timeMeditationChartMap['minutes'],
      date: timeMeditationChartMap['date'],
    );
  }
}
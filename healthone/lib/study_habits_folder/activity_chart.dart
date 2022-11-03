class ActivityChart {
  final double minutes;
  final String classCode;

  ActivityChart({
    required this.minutes,
    required this.classCode,
  });

  factory ActivityChart.fromMap(Map activityChart) {
    return ActivityChart(
      minutes: activityChart['minutes'],
      classCode: activityChart['classCode'],
    );
  }
}

class ExerciseMentalComparison {
  final double minutes;
  final String mood;
  final String stress;
  final String date;

  ExerciseMentalComparison({
    required this.minutes,
    required this.mood,
    required this.stress,
    required this.date,
  });

  factory ExerciseMentalComparison.fromMap(Map exerciseMentalMap){
    return ExerciseMentalComparison(
      minutes: exerciseMentalMap['minutes'],
      mood: exerciseMentalMap['mood'],
      stress: exerciseMentalMap['stress'],
      date: exerciseMentalMap['date'],
    );
  }
}
class Mood{
  final int id;
  final String userName;
  final String mood;
  final String stress;
  final String month;
  final String year;
  final String day;

  Mood({
    required this.id,
    required this.userName,
    required this.mood,
    required this.stress,
    required this.month,
    required this.year,
    required this.day,
  });

  factory Mood.fromMap(Map moodMap){
    return Mood(
      id: moodMap['id'],
      userName: moodMap['userName'],
      mood: moodMap['mood'],
      stress: moodMap['stress'],
      year: moodMap['year'],
      day: moodMap['day'],
      month: moodMap['month'],
    );

  }
}
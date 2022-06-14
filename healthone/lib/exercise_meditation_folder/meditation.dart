class Meditation {
  final int meditation_id;
  final String meditation_name;
  final String meditation_type;

  Meditation({
    required this.meditation_id,
    required this.meditation_name,
    required this.meditation_type,
  });

  factory Meditation.fromMap(Map exerciseMap){
    return Meditation(
      meditation_id: exerciseMap['meditation_id'],
      meditation_name: exerciseMap['meditation_name'],
      meditation_type: exerciseMap['meditation_type'],
    );
  }
}
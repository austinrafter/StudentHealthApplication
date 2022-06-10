class Meditation {
  final int meditationId;
  final String meditationName;
  final String meditationType;

  Meditation({
    required this.meditationId,
    required this.meditationName,
    required this.meditationType,
  });

  factory Meditation.fromMap(Map exerciseMap){
    return Meditation(
      meditationId: exerciseMap['meditationId'],
      meditationName: exerciseMap['meditationName'],
      meditationType: exerciseMap['meditationType'],
    );
  }
}
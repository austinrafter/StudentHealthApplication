class Meditation {
  final int meditationid;
  final String meditationname;
  final String meditationtype;

  Meditation({
    required this.meditationid,
    required this.meditationname,
    required this.meditationtype,
  });

  factory Meditation.fromMap(Map exerciseMap){
    return Meditation(
      meditationid: exerciseMap['meditationid'],
      meditationname: exerciseMap['meditationname'],
      meditationtype: exerciseMap['meditationtype'],
    );
  }
}
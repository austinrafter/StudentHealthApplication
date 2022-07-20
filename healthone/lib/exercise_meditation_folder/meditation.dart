class Meditation {
  final int meditationid;
  final String meditationname;
  final String meditationtype;
  final String audiolink;
  final String imagelink;

  Meditation({
    required this.meditationid,
    required this.meditationname,
    required this.meditationtype,
    required this.audiolink,
    required this.imagelink,
  });

  factory Meditation.fromMap(Map exerciseMap){
    return Meditation(
      meditationid: exerciseMap['meditationid'],
      meditationname: exerciseMap['meditationname'],
      meditationtype: exerciseMap['meditationtype'],
      audiolink: exerciseMap['audiolink'],
      imagelink: exerciseMap['imagelink'],
    );
  }
}
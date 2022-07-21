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

  factory Meditation.fromMap(Map meditationMap){
    return Meditation(
      meditationid: meditationMap['meditationid'],
      meditationname: meditationMap['meditationname'],
      meditationtype: meditationMap['meditationtype'],
      audiolink: meditationMap['audiolink'],
      imagelink: meditationMap['imagelink'],
    );
  }
}
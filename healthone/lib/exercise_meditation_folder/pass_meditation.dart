class PassMeditation {
  final int passmeditationid;
  final String meditationname;
  final String username;
  final String dateof;
  final int totaltime;
  final String soundused;

  PassMeditation({
    required this.passmeditationid,
    required this.meditationname,
    required this.username,
    required this.dateof,
    required this.totaltime,
    required this.soundused,
  });

  factory PassMeditation.fromMap(Map studentMeditatingMap){
    return PassMeditation(
      passmeditationid: studentMeditatingMap['passmeditationid'],
      meditationname: studentMeditatingMap['meditationname'],
      username: studentMeditatingMap['username'],
      dateof: studentMeditatingMap['dateof'],
      totaltime: studentMeditatingMap['totaltime'],
      soundused: studentMeditatingMap['soundused'],
    );
  }

}//class
class PassMeditation {
  final int passmeditationid;
  final String meditationname;
  final String username;
  final String startedat;
  final String endedat;
  final int totaltime;
  final String soundused;

  PassMeditation({
    required this.passmeditationid,
    required this.meditationname,
    required this.username,
    required this.startedat,
    required this.endedat,
    required this.totaltime,
    required this.soundused,
  });

  factory PassMeditation.fromMap(Map studentMeditatingMap){
    return PassMeditation(
      passmeditationid: studentMeditatingMap['passmeditationid'],
      meditationname: studentMeditatingMap['meditationname'],
      username: studentMeditatingMap['username'],
      startedat: studentMeditatingMap['startedat'],
      endedat: studentMeditatingMap['endedat'],
      totaltime: studentMeditatingMap['totaltime'],
      soundused: studentMeditatingMap['soundused'],
    );
  }

}//class
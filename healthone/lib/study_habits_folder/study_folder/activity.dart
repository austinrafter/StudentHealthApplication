class Activity {
  final int id;
  final String classCode;
  final String semester;
  final int duration;

  Activity({
    required this.id,
    required this.classCode,
    required this.semester,
    required this.duration,
  });

  factory Activity.fromMap(Map studyClassMap) {
    return Activity(
      id: studyClassMap['id'],
      classCode: studyClassMap['classCode'],
      semester: studyClassMap['semester'],
      duration: studyClassMap['duration'],
    );
  }
}

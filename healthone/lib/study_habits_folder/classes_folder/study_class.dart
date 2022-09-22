class StudyClass {
  final int id;
  final String code;
  final String name;
  final double point;
  final String grade;

  StudyClass({
    required this.id,
    required this.code,
    required this.name,
    required this.point,
    required this.grade,
  });

  factory StudyClass.fromMap(Map studyClassMap) {
    return StudyClass(
      id: studyClassMap['id'],
      code: studyClassMap['code'],
      name: studyClassMap['name'],
      point: studyClassMap['point'],
      grade: studyClassMap['grade'],
    );
  }
}

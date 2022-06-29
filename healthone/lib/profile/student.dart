class Student {
  final int student_id;
  final String user_name;
  final String email;
  final String school;
  final double weight;

  Student({
    required this.student_id,
    required this.user_name,
    required this.email,
    required this.school,
    required this.weight,
  });

  factory Student.fromMap(Map studentMap){
    return Student(
      student_id: studentMap['student_id'],
      user_name: studentMap['user_name'],
      email: studentMap['email'],
      school: studentMap['school'],
      weight: studentMap['weight'],
    );
  }
}
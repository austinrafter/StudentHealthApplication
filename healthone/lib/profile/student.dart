class Student {
  final int studentid;
  final String username;
  final String email;
  final String school;
  final double weight;

  Student({
    required this.studentid,
    required this.username,
    required this.email,
    required this.school,
    required this.weight,
  });

  factory Student.fromMap(Map studentMap){
    return Student(
      studentid: studentMap['studentid'],
      username: studentMap['username'],
      email: studentMap['email'],
      school: studentMap['school'],
      weight: studentMap['weight'],
    );
  }
}
import 'package:hamon/features/students/domain/entities/student.dart';

class StudentModel extends Student {
  const StudentModel({
   required int id,
   required String name,
   required String email,
   required int age,
  }) : super(id: id, name: name,email: email,age: age);

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age,
    };
  }
}

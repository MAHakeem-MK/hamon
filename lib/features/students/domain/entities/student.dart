import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final int id;
  final String name;
  final String email;
  final int age;
  
  const Student({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
  });

  Student copyWith({
    int? id,
    String? name,
    String? email,
    int? age,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      age: age ?? this.age,
    );
  }

  @override
  List<Object?> get props => [id];
}

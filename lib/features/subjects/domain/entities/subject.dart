import 'package:equatable/equatable.dart';

class Subject extends Equatable {
  final int id;
  final String name;
  final String teacher;
  final int credits;

  const Subject({
    required this.id,
    required this.name,
    required this.teacher,
    required this.credits,
  });

  Subject copyWith({
    int? id,
    String? name,
    String? teacher,
    int? credits,
  }) {
    return Subject(
      id: id ?? this.id,
      name: name ?? this.name,
      teacher: teacher ?? this.teacher,
      credits: credits ?? this.credits,
    );
  }

  @override
  List<Object?> get props => [id];
}

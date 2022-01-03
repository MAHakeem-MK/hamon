import 'package:equatable/equatable.dart';
import 'package:hamon/features/classrooms/domain/entities/classroom_type.dart';

class Classroom extends Equatable {
  final int id;
  final String name;
  final String subject;
  final ClassroomType layout;
  final int size;

  const Classroom({
    required this.id,
    required this.name,
    required this.subject,
    required this.layout,
    required this.size,
  });

  Classroom copyWith({
    int? id,
    String? name,
    String? subject,
    ClassroomType? layout,
    int? size,
  }) {
    return Classroom(
      id: id ?? this.id,
      name: name ?? this.name,
      subject: subject ?? this.subject,
      layout: layout ?? this.layout,
      size: size ?? this.size,
    );
  }

  @override
  List<Object?> get props => [id];
}

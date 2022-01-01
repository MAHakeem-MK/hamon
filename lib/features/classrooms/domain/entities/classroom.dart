import 'package:equatable/equatable.dart';

class Classroom extends Equatable {
  final int id;
  final String name;
  final String subject;
  final String layout;
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
    String? layout,
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

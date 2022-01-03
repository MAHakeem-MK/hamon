import 'package:hamon/features/classrooms/domain/entities/classroom.dart';

class ClassroomModel extends Classroom {
  const ClassroomModel({
    required id,
    required name,
    required subject,
    required layout,
    required size,
  }):super(id: id, name: name, subject: subject, layout: layout, size: size);

  factory ClassroomModel.fromJson(Map<String, dynamic> json) {
    return ClassroomModel(
      id: json['id'],
      name: json['name'] ?? '',
      subject: json['subject'] ?? '',
      layout: json['layout'] ?? '',
      size: json['size'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subject': subject,
      'layout': layout,
      'size': size,
    };
  }
}

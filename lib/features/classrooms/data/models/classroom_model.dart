import 'package:hamon/features/classrooms/domain/entities/classroom.dart';
import 'package:hamon/features/classrooms/util/classroom_layout_converter.dart';

class ClassroomModel extends Classroom {
  const ClassroomModel({
    required id,
    required name,
    required subject,
    required layout,
    required size,
  }) : super(id: id, name: name, subject: subject, layout: layout, size: size);

  factory ClassroomModel.fromJson(Map<String, dynamic> json) {
    return ClassroomModel(
      id: json['id'],
      name: json['name'] ?? '',
      subject: json['subject'].toString(),
      layout: convertToLayoutType((json['layout'] ?? '').toString()),
      size: json['size'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subject': subject,
      'layout': convertToString(layout),
      'size': size,
    };
  }
  
}

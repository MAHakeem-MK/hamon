import 'package:hamon/features/classrooms/domain/entities/classroom_type.dart';

ClassroomType convertToLayoutType(String layout) {
  switch (layout) {
    case 'classroom':
      return ClassroomType.classroom;
    case 'conference':
      return ClassroomType.conference;
    default:
      return ClassroomType.unknown;
  }
}

String convertToString(ClassroomType type) {
  return type.name;
}

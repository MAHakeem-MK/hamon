import 'package:hamon/features/subjects/domain/entities/subject.dart';

class SubjectModel extends Subject {
  const SubjectModel(
    int id,
    String name,
    String teacher,
    int credits,
  ) : super(id: id, name: name, teacher: teacher, credits: credits);

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      json['id'],
      json['name'],
      json['teacher'],
      json['credits'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'teacher': teacher,
      'credits': credits,
    };
  }
}

import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamon/features/students/data/models/student_model.dart';
import 'package:hamon/features/students/domain/entities/student.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tStudentModel = StudentModel(
    id: 1,
    name: 'test name',
    age: 20,
    email: 'mail@email.com',
  );

  test('should be of type Student', () {
    expect(tStudentModel, isA<Student>());
  });

  group(
    'from JSON',
    () {
      test(
        'should return a valid model',
        () async {
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('student.json'));
          final result = StudentModel.fromJson(jsonMap);
          expect(result, tStudentModel);
        },
      );
    },
  );

  group(
    'to JSON',
    () {
      test(
        'should return a JSON map containing the proper data',
        () async {
          final result = tStudentModel.toJson();
          final expectedMap = {
            "age": 20,
            "email": "mail@email.com",
            "id": 1,
            "name": "test name"
          };
          expect(result, expectedMap);
        },
      );
    },
  );
}

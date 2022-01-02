import 'dart:convert';

import 'package:hamon/features/students/data/models/student_model.dart';
import 'package:http/http.dart' as http;

abstract class StudentsRemoteDataSource {
  Future<List<StudentModel>> getStudents();
  Future<StudentModel> getStudent(int id);
}

class StudentsRemoteDataSourceImpl implements StudentsRemoteDataSource {
  final http.Client client;
  StudentsRemoteDataSourceImpl({required this.client});
  @override
  Future<StudentModel> getStudent(int id) {
    return client
        .get(
      Uri.parse(
        'https://hamon-interviewapi.herokuapp.com/student/$id?api_key=6c5Fc',
      ),
    )
        .then((response) {
      if (response.statusCode == 200) {
        return StudentModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load content');
      }
    });
  }

  @override
  Future<List<StudentModel>> getStudents() {
    return client
        .get(
      Uri.parse(
        'https://hamon-interviewapi.herokuapp.com/students?api_key=6c5Fc',
      ),
    ).then((response) {
      if (response.statusCode == 200) {
        Map<String,dynamic> jsonResponse = json.decode(response.body);
        return (jsonResponse['students'] as List)
            .map((student) => StudentModel.fromJson(student))
            .toList();
      } else {
        throw Exception('Failed to load content ${response.statusCode}');
      }
    });
  }
}

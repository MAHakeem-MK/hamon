import 'dart:convert';
import 'package:hamon/features/classrooms/data/models/classroom_model.dart';
import 'package:http/http.dart' as http;

abstract class ClassroomsRemoteDataSource {
  Future<List<ClassroomModel>> getClassrooms();
  Future<ClassroomModel> getClassroom(int id);
}

class ClassroomsRemoteDataSourceImpl implements ClassroomsRemoteDataSource {
  final http.Client client;

  ClassroomsRemoteDataSourceImpl({required this.client});
  @override
  Future<ClassroomModel> getClassroom(int id) {
    return client.get(Uri.parse('https://hamon-interviewapi.herokuapp.com/classrooms/$id?api_key=6c5Fc')).then((response) {
      if (response.statusCode == 200) {
        return ClassroomModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load content');
      }
    });
  }

  @override
  Future<List<ClassroomModel>> getClassrooms() {
    return client.get(Uri.parse('https://hamon-interviewapi.herokuapp.com/classrooms?api_key=6c5Fc')).then((response) {
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return (jsonResponse['classrooms'] as List).map((item) => ClassroomModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load content');
      }
    });
  }
}

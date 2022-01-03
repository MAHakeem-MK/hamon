import 'dart:convert';

import 'package:hamon/features/subjects/data/models/subject_model.dart';
import 'package:http/http.dart' as http;

abstract class SubjectsRemoteDataSource {
  Future<List<SubjectModel>> getSubjects();
  Future<SubjectModel> getSubject(int id);
}

class SubjectsRemoteDataSourceImpl implements SubjectsRemoteDataSource {
  final http.Client client;
  SubjectsRemoteDataSourceImpl(this.client);
  @override
  Future<SubjectModel> getSubject(int id) {
    return client.get(
      Uri.parse(
        'https://hamon-interviewapi.herokuapp.com/subjects/$id?api_key=6c5Fc',
      ),
    ).then((response) {
      if (response.statusCode == 200) {
        return SubjectModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load content ${response.statusCode}');
      }
    });
  }

  @override
  Future<List<SubjectModel>> getSubjects() {
    return client.get(
      Uri.parse(
        'https://hamon-interviewapi.herokuapp.com/subjects?api_key=6c5Fc',
      ),
    ).then((response) {
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return (jsonResponse["subjects"] as List)
            .map((subject) => SubjectModel.fromJson(subject))
            .toList();
      } else {
        throw Exception('Failed to load content ${response.statusCode}');
      }
    });
  }
}

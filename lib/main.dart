import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamon/core/platform/network_info.dart';
import 'package:hamon/features/classrooms/data/datasources/classrooms_remote_data_source.dart';
import 'package:hamon/features/classrooms/data/repositories/classroom_repository_impl.dart';
import 'package:hamon/features/classrooms/domain/usecases/assign_subject.dart';
import 'package:hamon/features/classrooms/domain/usecases/get_classroom.dart';
import 'package:hamon/features/classrooms/presentation/bloc/classroom_bloc.dart';
import 'package:hamon/features/classrooms/presentation/pages/classrooms_page.dart';
import 'package:hamon/features/students/presentation/pages/students_page.dart';
import 'package:hamon/features/subjects/data/datasources/subjects_remote_data_source.dart';
import 'package:hamon/features/subjects/data/repositories/subjects_repository_impl.dart';
import 'package:hamon/features/subjects/presentation/bloc/subject_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider<ClassroomBloc>(
          create: (context) => ClassroomBloc(
            GetClassroom(
              ClassroomRepositoryImpl(
                remoteDataSource: ClassroomsRemoteDataSourceImpl(
                  client: http.Client(),
                ),
                networkInfo: NetworkInfo(),
              ),
            ),
            AssignSubject(
              ClassroomRepositoryImpl(
                remoteDataSource:
                    ClassroomsRemoteDataSourceImpl(client: http.Client()),
                networkInfo: NetworkInfo(),
              ),
            ),
            SubjectBloc(
              SubjectsRepositoryImpl(
                networkInfo: NetworkInfo(),
                remoteDataSource: SubjectsRemoteDataSourceImpl(
                  http.Client(),
                ),
              ),
            ),
          ),
        )
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hamon'),
        centerTitle: true,
      ),
      body: GridView.count(crossAxisCount: 2, children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const ClassroomsPage()),
                );
              },
              icon: const Icon(Icons.school),
              label: const Text('Classrooms')),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const StudentsPage()),
                );
              },
              icon: const Icon(Icons.people),
              label: const Text('Students')),
        ),
      ]),
    );
  }
}

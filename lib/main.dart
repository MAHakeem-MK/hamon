import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamon/core/platform/network_info.dart';
import 'package:hamon/features/students/data/datasources/students_remote_data_source.dart';
import 'package:hamon/features/students/data/repositories/students_repository_impl.dart';
import 'package:hamon/features/students/domain/usecases/get_students.dart';
import 'package:hamon/features/students/presentation/bloc/students_bloc.dart';
import 'package:hamon/features/students/presentation/pages/students_page.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => StudentsBloc(
          getStudentsUseCase: GetStudents(
            StudentsRepositoryImpl(
              remoteDataSource: StudentsRemoteDataSourceImpl(
                client: http.Client(),
              ),
              networkInfo: NetworkInfo(),
            ),
          ),
        ),
        child: const StudentsPage(),
      ),
    );
  }
}

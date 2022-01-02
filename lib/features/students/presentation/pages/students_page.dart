import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamon/core/platform/network_info.dart';
import 'package:hamon/features/students/data/datasources/students_remote_data_source.dart';
import 'package:hamon/features/students/data/repositories/students_repository_impl.dart';
import 'package:hamon/features/students/domain/usecases/get_students.dart';
import 'package:hamon/features/students/presentation/bloc/students_bloc.dart';
import 'package:hamon/features/students/presentation/pages/student_detail_page.dart';
import 'package:http/http.dart' as http;

class StudentsPage extends StatelessWidget {
  const StudentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
      child: const StudentsView(),
    );
  }
}

class StudentsView extends StatefulWidget {
  const StudentsView({Key? key}) : super(key: key);

  @override
  _StudentsViewState createState() => _StudentsViewState();
}

class _StudentsViewState extends State<StudentsView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StudentsBloc>(context).add(GetStudentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        centerTitle: true,
      ),
      body: BlocConsumer<StudentsBloc, StudentsState>(
        listener: (context, state) {
          if (state is StudentsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is StudentsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is StudentsLoaded) {
            return ListView.separated(
              itemCount: state.students.length,
              itemBuilder: (context, index) {
                final student = state.students[index];
                return ListTile(
                  title: Text(student.name,style: _textTheme.headline5),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StudentDetailPage(studentId: student.id),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          }
          return Container();
        },
      ),
    );
  }
}

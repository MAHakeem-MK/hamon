import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamon/core/platform/network_info.dart';
import 'package:hamon/features/students/data/datasources/students_remote_data_source.dart';
import 'package:hamon/features/students/data/repositories/students_repository_impl.dart';
import 'package:hamon/features/students/domain/usecases/get_student.dart';
import 'package:hamon/features/students/presentation/bloc/student_bloc.dart';
import 'package:http/http.dart' as http;

class StudentDetailPage extends StatelessWidget {
  final int studentId;
  const StudentDetailPage({Key? key, required this.studentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentBloc(
        getStudentUseCase: GetStudent(
          StudentsRepositoryImpl(
            remoteDataSource:
                StudentsRemoteDataSourceImpl(client: http.Client()),
            networkInfo: NetworkInfo(),
          ),
        ),
      ),
      child: StudentDetailView(studentId: studentId),
    );
  }
}

class StudentDetailView extends StatefulWidget {
  final int studentId;
  const StudentDetailView({Key? key, required this.studentId})
      : super(key: key);

  @override
  _StudentDetailViewState createState() => _StudentDetailViewState();
}

class _StudentDetailViewState extends State<StudentDetailView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StudentBloc>(context).add(
      GetStudentEvent(widget.studentId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Detail'),
        centerTitle: true,
      ),
      body: BlocConsumer<StudentBloc, StudentState>(
        listener: (context, state) {
          if (state is StudentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is StudentLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is StudentLoaded) {
            return Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.topCenter,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(state.student.name, style: _textTheme.headline4),
                      const Divider(),
                      DetailRow(label: 'AGE',value: state.student.age.toString()),
                      DetailRow(label: 'E-MAIL',value: state.student.email),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const DetailRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text('$label : ', style: _textTheme.subtitle1),
          Text(value, style: _textTheme.subtitle1),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamon/features/students/presentation/bloc/students_bloc.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({Key? key}) : super(key: key);

  @override
  _StudentsPageState createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StudentsBloc>(context).add(GetStudentsEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return ListView.builder(
              itemCount: state.students.length,
              itemBuilder: (context, index) {
                final student = state.students[index];
                return ListTile(
                  title: Text(student.name),
                  subtitle: Text(student.email),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}

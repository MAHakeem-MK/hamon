import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamon/features/classrooms/domain/entities/classroom_type.dart';
import 'package:hamon/features/classrooms/presentation/bloc/classroom_bloc.dart';
import 'package:hamon/features/classrooms/presentation/widgets/classroom_layout.dart';
import 'package:hamon/features/classrooms/presentation/widgets/conference_layout.dart';
import 'package:hamon/features/subjects/presentation/pages/subjects_page.dart';

class ClassroomDetailPage extends StatefulWidget {
  final int id;
  const ClassroomDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _ClassroomDetailPageState createState() => _ClassroomDetailPageState();
}

class _ClassroomDetailPageState extends State<ClassroomDetailPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClassroomBloc>(context).add(GetClassroomEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classroom Detail'),
        centerTitle: true,
      ),
      body: BlocConsumer<ClassroomBloc, ClassroomState>(
        listener: (context, state) {
          if (state is ClassroomError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ClassroomLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ClassroomLoaded) {
            return Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.topCenter,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(state.classroom.name, style: _textTheme.headline4),
                      Text(state.classroom.subject,
                          style: _textTheme.subtitle1),
                      const Divider(),
                      _getClassroomLayout(
                        state.classroom.layout,
                        state.classroom.size,
                      ),
                      ButtonBar(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SubjectsPage(
                                      classId: state.classroom.id,
                                    );
                                  },
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                            child: const Text('Assign Subject'),
                          ),
                        ],
                      )
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

  _getClassroomLayout(ClassroomType type, int noOfStudents) {
    switch (type) {
      case ClassroomType.classroom:
        return ClassroomLayout(noOfStudents: noOfStudents);
      case ClassroomType.conference:
        return ConferenceLayout(noOfStudents: noOfStudents);
      default:
        return const Center(child: Text('Unknown'));
    }
  }
}

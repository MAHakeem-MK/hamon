import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamon/core/platform/network_info.dart';
import 'package:hamon/features/classrooms/data/datasources/classrooms_remote_data_source.dart';
import 'package:hamon/features/classrooms/data/repositories/classroom_repository_impl.dart';
import 'package:hamon/features/classrooms/domain/entities/classroom_type.dart';
import 'package:hamon/features/classrooms/domain/usecases/get_classroom.dart';
import 'package:hamon/features/classrooms/presentation/bloc/classroom_bloc.dart';
import 'package:http/http.dart' as http;

class ClassroomDetailPage extends StatelessWidget {
  final int id;
  const ClassroomDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClassroomBloc(
        GetClassroom(
          ClassroomRepositoryImpl(
              remoteDataSource: ClassroomsRemoteDataSourceImpl(
                client: http.Client(),
              ),
              networkInfo: NetworkInfo()),
        ),
      ),
      child: _ClassroomDetailView(id: id),
    );
  }
}

class _ClassroomDetailView extends StatefulWidget {
  final int id;
  const _ClassroomDetailView({Key? key, required this.id}) : super(key: key);

  @override
  __ClassroomDetailViewState createState() => __ClassroomDetailViewState();
}

class __ClassroomDetailViewState extends State<_ClassroomDetailView> {
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
                      const Divider(),
                      _getClassroomLayout(
                          state.classroom.layout, state.classroom.size)
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

class ClassroomLayout extends StatelessWidget {
  final int noOfStudents;
  const ClassroomLayout({
    Key? key,
    required this.noOfStudents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 150,
      child: Row(
        children: [
          const Icon(
            Icons.emoji_people_rounded,
            size: 40,
          ),
          const SizedBox(width: 25),
          Expanded(
            child: GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: noOfStudents,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                ),
                itemBuilder: (_, i) {
                  return const Icon(Icons.person);
                }),
          )
        ],
      ),
    );
  }
}

class ConferenceLayout extends StatelessWidget {
  final int noOfStudents;
  const ConferenceLayout({
    Key? key,
    required this.noOfStudents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 150,
      child: Row(
        children: [
          const Icon(
            Icons.emoji_people_rounded,
            size: 40,
          ),
          const SizedBox(width: 25),
          Expanded(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(color:Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: noOfStudents,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 24,
                            mainAxisExtent: 18),
                    itemBuilder: (_, i) {
                      return const Icon(Icons.person);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

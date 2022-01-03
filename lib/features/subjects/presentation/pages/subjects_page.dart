import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamon/core/platform/network_info.dart';
import 'package:hamon/features/classrooms/presentation/bloc/classroom_bloc.dart';
import 'package:hamon/features/subjects/data/datasources/subjects_remote_data_source.dart';
import 'package:hamon/features/subjects/data/repositories/subjects_repository_impl.dart';
import 'package:hamon/features/subjects/domain/usecases/get_subjects.dart';
import 'package:hamon/features/subjects/presentation/bloc/subjects_bloc.dart';
import 'package:http/http.dart' as http;

class SubjectsPage extends StatelessWidget {
  final int classId;
  const SubjectsPage({Key? key, required this.classId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SubjectsBloc>(
          create: (context) => SubjectsBloc(
            GetSubjects(
              SubjectsRepositoryImpl(
                networkInfo: NetworkInfo(),
                remoteDataSource: SubjectsRemoteDataSourceImpl(
                  http.Client(),
                ),
              ),
            ),
          ),
        ),
      ],
      child: _SubjectsView(classId: classId),
    );
  }
}

class _SubjectsView extends StatefulWidget {
  final int classId;
  const _SubjectsView({Key? key, required this.classId}) : super(key: key);

  @override
  __SubjectsViewState createState() => __SubjectsViewState();
}

class __SubjectsViewState extends State<_SubjectsView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SubjectsBloc>(context).add(GetSubjectsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Subject'),
        centerTitle: true,
      ),
      body: BlocConsumer<SubjectsBloc, SubjectsState>(
        listener: (context, state) {
          if (state is SubjectsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SubjectsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SubjectsLoaded) {
            return ListView.separated(
              itemCount: state.subjects.length,
              itemBuilder: (context, index) {
                final subject = state.subjects[index];
                return ListTile(
                  title: Text(subject.name, style: _textTheme.headline5),
                  onTap: () {
                    BlocProvider.of<ClassroomBloc>(context).add(AssignSubjectEvent(widget.classId, subject.id));
                    Navigator.pop(context);
                  },
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

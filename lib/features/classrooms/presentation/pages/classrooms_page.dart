import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamon/core/platform/network_info.dart';
import 'package:hamon/features/classrooms/data/datasources/classrooms_remote_data_source.dart';
import 'package:hamon/features/classrooms/data/repositories/classroom_repository_impl.dart';
import 'package:hamon/features/classrooms/domain/usecases/get_classrooms.dart';
import 'package:hamon/features/classrooms/presentation/bloc/classrooms_bloc.dart';
import 'package:hamon/features/classrooms/presentation/pages/classroom_detail_page.dart';
import 'package:http/http.dart' as http;

class ClassroomsPage extends StatelessWidget {
  const ClassroomsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClassroomsBloc(
        GetClassrooms(
          ClassroomRepositoryImpl(
              remoteDataSource: ClassroomsRemoteDataSourceImpl(
                client: http.Client(),
              ),
              networkInfo: NetworkInfo()),
        ),
      ),
      child: const ClassroomsView(),
    );
  }
}

class ClassroomsView extends StatefulWidget {
  const ClassroomsView({Key? key}) : super(key: key);

  @override
  _ClassroomsViewState createState() => _ClassroomsViewState();
}

class _ClassroomsViewState extends State<ClassroomsView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClassroomsBloc>(context).add(
      GetClassroomsEvent(),
    );
  }
  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classrooms'),
        centerTitle: true,
      ),
      body: BlocConsumer<ClassroomsBloc, ClassroomsState>(
        listener: (context, state) {
          if (state is ClassroomsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ClassroomsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ClassroomsLoaded) {
            return ListView.separated(
              itemCount: state.classrooms.length,
              itemBuilder: (context, index) {
                final classroom = state.classrooms[index];
                return ListTile(
                  title: Text(classroom.name,style: _textTheme.headline5),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClassroomDetailPage(id: classroom.id))),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          }
          return const Center(
            child: Text('Something went wrong'),
          );
        },
      ),
    );
  }
}

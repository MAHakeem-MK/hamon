import 'package:flutter/material.dart';
import 'package:hamon/features/classrooms/presentation/pages/classrooms_page.dart';
import 'package:hamon/features/students/presentation/pages/students_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
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
      body: GridView.count(
          crossAxisCount: 2,
          
          children: <Widget>[
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
                      MaterialPageRoute(
                          builder: (context) => const StudentsPage()),
                    );
                  },
                  icon: const Icon(Icons.people),
                  label: const Text('Students')),
            ),
          ]),
    );
  }
}

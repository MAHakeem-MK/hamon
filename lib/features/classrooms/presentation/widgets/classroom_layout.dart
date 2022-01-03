import 'package:flutter/material.dart';

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
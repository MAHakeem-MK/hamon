import 'package:flutter/material.dart';

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
                      border: Border.all(color: Colors.blue, width: 2),
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

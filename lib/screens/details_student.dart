import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms/update_bloc/update_bloc_bloc.dart';

class DetailsOfStudent extends StatelessWidget {
  DetailsOfStudent({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UpdateBlocBloc>(context).add(DetalisShow());

    return BlocBuilder<UpdateBlocBloc, UpdateBlocState>(
      builder: (context, state) {
        if (state.values.length <= index) {
          // Handle case where the index is out of bounds
          return Scaffold(
            body: Center(
              child: Text("Invalid index $index"),
            ),
          );
        }

        final data = state.values[index];

        return Scaffold(
          appBar: AppBar(
            title: const Text("Student Details"),
          ),
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: data.image == "assets/student.jpg"
                            ? const AssetImage("assets/student.jpg")
                                as ImageProvider
                            : FileImage(File(data.image)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          const Text(
                            "Name: ",
                            style: TextStyle(fontSize: 30),
                          ),
                          Expanded(
                            child: Text(
                              data.name,
                              style: const TextStyle(fontSize: 30),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          const Spacer()
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 57,
                          ),
                          const Text(
                            "Age: ",
                            style: TextStyle(fontSize: 30),
                          ),
                          Expanded(
                            child: Text(
                              data.age,
                              style: const TextStyle(fontSize: 30),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          const Spacer()
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          const Text(
                            "Course: ",
                            style: TextStyle(fontSize: 30),
                          ),
                          Expanded(
                            child: Text(
                              data.course,
                              style: const TextStyle(fontSize: 30),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          const Spacer()
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 50,
                          ),
                          const Text(
                            "Year: ",
                            style: TextStyle(fontSize: 30),
                          ),
                          Expanded(
                            child: Text(
                              data.year,
                              style: const TextStyle(fontSize: 30),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          const Spacer()
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

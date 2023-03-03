import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms/core/constants.dart';
import 'package:sms/list_view/list_view_bloc.dart';
import 'package:sms/model/dbfunction.dart';
import 'package:sms/screens/details_student.dart';

import '../debouncer/debouncer.dart';

class ListofDetails extends StatelessWidget {
  ListofDetails({Key? key}) : super(key: key);
  final _debouncer = Debouncer(milliseconds: 1 * 1000);
  int? iindex;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ListViewBloc>(context).add(ListViewManage());
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Details"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: iconofSearch,
          ),
          Expanded(
            child: TextField(
              onChanged: (value) {
                _debouncer.run(() {
                  BlocProvider.of<ListViewBloc>(context).add(
                    ListSearchView(query: value),
                  );
                });
              },
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue,
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(child: BlocBuilder<ListViewBloc, ListViewState>(
            builder: (context, state) {
              if (state.filterdValue.isNotEmpty) {
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        // onTap: () => Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => DetailsOfStudent(
                        //               index: index,
                        //             ))),
                        title: Text(state.filterdValue[index].name),
                        leading: CircleAvatar(
                            radius: 30,
                            child: CircleAvatar(
                                backgroundImage: state
                                            .filterdValue[index].image ==
                                        'assets/student.jpg'
                                    ? const AssetImage('assets/student.jpg')
                                        as ImageProvider
                                    : FileImage(
                                        File(state.filterdValue[index].image)),
                                radius: 30)),
                        trailing: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete Confirmation'),
                                  content: const Text(
                                      'Are you sure you want to delete this item?'),
                                  actions: [
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Delete'),
                                      onPressed: () {
                                        BlocProvider.of<ListViewBloc>(context)
                                            .add(ListStudentDelete(
                                                index: index));

                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: deleteIcon,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: state.filterdValue.length);
              } else if (state.value.isEmpty) {
                return const Center(
                  child: Text("No data"),
                );
              }
              return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsOfStudent(
                              index: state.value
                                  .indexOf(state.value.elementAt(index)),
                            ),
                          ),
                        );
                      },
                      title: Text(state.value[index].name),
                      leading: CircleAvatar(
                          radius: 30,
                          child: CircleAvatar(
                              backgroundImage: state.value[index].image ==
                                      'assets/student.jpg'
                                  ? const AssetImage('assets/student.jpg')
                                      as ImageProvider
                                  : FileImage(File(state.value[index].image)),
                              radius: 30)),
                      trailing: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Delete Confirmation'),
                                content: const Text(
                                    'Are you sure you want to delete this item?'),
                                actions: [
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Delete'),
                                    onPressed: () {
                                      BlocProvider.of<ListViewBloc>(context)
                                          .add(ListStudentDelete(index: index));
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        BlocProvider.of<ListViewBloc>(context)
                                            .add(ListViewManage());
                                      });

                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: deleteIcon,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: state.value.length);
            },
          )),
        ],
      ),
    );
  }
}
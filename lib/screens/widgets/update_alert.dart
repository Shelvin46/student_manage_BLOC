import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms/model/dbfunction.dart';
import 'package:sms/update_bloc/update_bloc_bloc.dart';

import '../../list_view/list_view_bloc.dart';
import '../../model/database_model.dart';

class MyAlertDialog extends StatelessWidget {
  MyAlertDialog({super.key, required this.index});
  final int index;
  final updateNameController = TextEditingController();
  final updateAgeController = TextEditingController();
  final updateCourseController = TextEditingController();
  final updateYearController = TextEditingController();
  String? imagefile;
  String? imagefile1;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<UpdateBlocBloc>(context).add(DetalisShow());
    });

    return BlocBuilder<UpdateBlocBloc, UpdateBlocState>(
      builder: (context, state) {
        updateNameController.text = state.values[index].name;
        updateAgeController.text = state.values[index].age;
        updateCourseController.text = state.values[index].course;
        updateYearController.text = state.values[index].year;

        Widget imageWidget;
        if (state.image == null) {
          imagefile = state.values[index].image;
          imageWidget = CircleAvatar(
            backgroundImage: state.values[index].image == "assets/student.jpg"
                ? const AssetImage("assets/student.jpg") as ImageProvider
                : FileImage(File(state.values[index].image)),
            radius: 80,
            child: Padding(
              padding: const EdgeInsets.only(top: 110),
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet(context)),
                  );
                },
                icon: const Icon(Icons.add_a_photo_rounded),
                color: Colors.white,
                iconSize: 40,
              ),
            ),
          );
        } else {
          imagefile1 = state.image!.path;
          imageWidget = CircleAvatar(
            backgroundImage: FileImage(File(state.image!.path)),
            radius: 80,
            child: Padding(
              padding: const EdgeInsets.only(top: 110),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_a_photo_rounded),
                color: Colors.white,
                iconSize: 40,
              ),
            ),
          );
        }

        return AlertDialog(
          title: const Text('Update Student Details'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                imageWidget,
                TextField(
                  controller: updateNameController,
                  onChanged: (value) {},
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
                TextField(
                  controller: updateAgeController,
                  onChanged: (value) {},
                  decoration: const InputDecoration(hintText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: updateCourseController,
                  onChanged: (value) {},
                  decoration: const InputDecoration(hintText: 'Course'),
                ),
                TextField(
                  onChanged: (value) {},
                  controller: updateYearController,
                  decoration: const InputDecoration(hintText: 'Year'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                    onPressed: () {
                      onUpdateButtonClicked(index, context);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.done),
                    label: const Text('Submit')),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> onUpdateButtonClicked(index, context) async {
    final updateName = updateNameController.text.trim();
    final updateAge = updateAgeController.text.trim();
    final updateCourse = updateCourseController.text.trim();
    final updateYear = updateYearController.text.trim();
    String studentImage;
    if (imagefile1 == null) {
      studentImage = imagefile!;
    } else {
      studentImage = imagefile1!;
    }

    // update other form fields first
    final values = StudentModel(
        name: updateName,
        age: updateAge,
        course: updateCourse,
        year: updateYear,
        image: studentImage); // initialize image to empty string

    await model.putAt(index, values);
    BlocProvider.of<UpdateBlocBloc>(context).add(DetalisShow());
    BlocProvider.of<ListViewBloc>(context).add(ListViewManage());

    // update image separately
    if (imagefile1 != null) {
      String studentImage = imagefile1!;
      final updatedValues = StudentModel(
          name: updateName,
          age: updateAge,
          course: updateCourse,
          year: updateYear,
          image: studentImage);

      await model.putAt(index, updatedValues);
      BlocProvider.of<UpdateBlocBloc>(context).add(DetalisShow());
      BlocProvider.of<ListViewBloc>(context).add(ListViewManage());
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blue,
        margin: EdgeInsets.all(10),
        content: Text('Updated')));
  }

  Widget bottomSheet(context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                width: 40,
              ),
              IconButton(
                icon: const Icon(Icons.image_search),
                onPressed: () {
                  BlocProvider.of<UpdateBlocBloc>(context)
                      .add(UpdateGalleryImage());
                  Navigator.pop(context);
                },
              ),
              const Text('Gallery'),
              const SizedBox(
                width: 50,
              ),
              IconButton(
                icon: const Icon(Icons.camera),
                onPressed: () {
                  BlocProvider.of<UpdateBlocBloc>(context)
                      .add(UpdateCameraImage());
                  Navigator.pop(context);
                },
              ),
              const Text('Camera'),
            ],
          )
        ],
      ),
    );
  }
}

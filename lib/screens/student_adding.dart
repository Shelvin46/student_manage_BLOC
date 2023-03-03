import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms/image_picker/image_picker_bloc.dart';
import 'package:sms/model/database_model.dart';
import 'package:sms/model/dbfunction.dart';

class AddStudent extends StatelessWidget {
  AddStudent({super.key});

  final studentNameCntrl = TextEditingController();
  final studentAgeCntrl = TextEditingController();
  final studentCourseCntrl = TextEditingController();
  final studentYearCntrl = TextEditingController();
  String? imagefile;
  String? imagefile1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Details"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(
                  child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
                    builder: (context, state) {
                      if (state.image == null) {
                        imagefile = "assets/student.jpg";
                        return CircleAvatar(
                          backgroundImage:
                              const AssetImage("assets/student.jpg"),
                          radius: MediaQuery.of(context).size.width * 0.2,
                          child: Padding(
                            padding: EdgeInsets.only(top: 110),
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet(context)),
                                );
                              },
                              icon: Icon(Icons.add_a_photo_rounded),
                              color: Colors.white,
                              iconSize: 40,
                            ),
                          ),
                        );
                      } else {
                        imagefile1 = state.image!.path;
                        return CircleAvatar(
                          backgroundImage: FileImage(File(state.image!.path)),
                          radius: MediaQuery.of(context).size.width * 0.2,
                          child: Padding(
                            padding: EdgeInsets.only(top: 110),
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet(context)),
                                );
                              },
                              icon: Icon(Icons.add_a_photo_rounded),
                              color: Colors.white,
                              iconSize: 40,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 50.0,
                  ),
                ),
                TextField(
                  controller: studentNameCntrl,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name of Student'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: studentAgeCntrl,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: studentCourseCntrl,
                  // controller: studentCourseCntrl,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Course'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: studentYearCntrl,
                  //controller: studentYearCntrl,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Year'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 100)),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await addRequiredField(context);

                        //
                      },
                      icon: const Icon(Icons.check_outlined),
                      label: const Text('Submit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addRequiredField(context) async {
    final studentName = studentNameCntrl.text.trim();
    final studentAge = studentAgeCntrl.text.trim();
    final studentCourse = studentCourseCntrl.text.trim();
    final studentYear = studentYearCntrl.text.trim();
    String studentImage;

    // Check if an image has been selected

    if (imagefile1 == null) {
      studentImage = imagefile!;
    } else {
      studentImage = imagefile1!;
    }

    // Check if any of the text form fields are empty
    if (studentName.isEmpty ||
        studentAge.isEmpty ||
        studentCourse.isEmpty ||
        studentYear.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Please fill all the fields'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      return;
    }

    final values = StudentModel(
      image: studentImage,
      name: studentName,
      age: studentAge,
      course: studentCourse,
      year: studentYear,
    );

    await model.add(values);
    BlocProvider.of<ImagePickerBloc>(context).add(RemoveImage());
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.blue,
      margin: EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      content: Text("Added Succesfully"),
      duration: Duration(seconds: 2),
    ));
    Navigator.of(context).pop();
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
                  BlocProvider.of<ImagePickerBloc>(context).add(GalleryImage());
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
                  BlocProvider.of<ImagePickerBloc>(context).add(CameraImage());
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

import 'package:flutter/material.dart';
import 'package:sms/core/constants.dart';
import 'package:sms/screens/student_adding.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome",
          style: appbarText,
        ),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: edgeInsets,
                child: Text(
                  "Click to Add Student",
                  style: homeText1,
                ),
              ),
              ElevatedButton.icon(
                label: const Text('Add Students'),
                icon: iconHome,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (contxt) => AddStudent()));
                },
              )
            ]),
      ),
    );
  }
}

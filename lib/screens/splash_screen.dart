import 'package:flutter/material.dart';

import 'package:sms/screens/bottomsheet.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    login(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "assets/student.jpg",
        fit: BoxFit.fill,
      ),
    );
  }
}

login(context) async {
  await Future.delayed(const Duration(seconds: 2));
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (contxt) => Botom()));
}

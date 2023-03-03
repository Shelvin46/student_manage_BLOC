import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms/bottom_nav_bar/bottom_nvaigation_bloc.dart';
import 'package:sms/image_picker/image_picker_bloc.dart';
import 'package:sms/list_view/list_view_bloc.dart';
import 'package:sms/model/database_model.dart';
import 'package:sms/screens/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sms/update_bloc/update_bloc_bloc.dart';
import 'model/dbfunction.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
  Hive.registerAdapter(StudentModelAdapter());
  openStudentModel();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return BottomNvaigationBloc();
          },
        ),
        BlocProvider(
          create: (context) {
            return ImagePickerBloc();
          },
        ),
        BlocProvider(
          create: (context) {
            return ListViewBloc();
          },
        ),
        BlocProvider(
          create: (context) {
            return UpdateBlocBloc();
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

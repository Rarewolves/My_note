import 'package:flutter/material.dart';

import 'package:flutter_application_25/model/note_model.dart';

import 'package:flutter_application_25/view/home_screen/home_screen.dart';
import 'package:flutter_application_25/view/splash_screen/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(ImageModelAdapter());

  var box = await Hive.openBox<NoteModel>('noteBox');
  var imbox = await Hive.openBox<ImageModel>('imageBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
    );
  }
}

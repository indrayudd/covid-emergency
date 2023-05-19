import 'package:emergency/ButtonInterface.dart';
import 'package:emergency/Form.dart';
import 'package:emergency/homePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:emergency/Login.dart';
import 'package:emergency/Start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.orange),
      debugShowCheckedModeBanner: false,
      home: MainActivity(),
      routes: <String, WidgetBuilder>{
        "Login": (BuildContext context) => Login(),
        "start": (BuildContext context) => Start(),
        "Form": (BuildContext context) => FormScreen(),
        "PPG": (BuildContext context) => HomePage(),
      },
    );
  }
}

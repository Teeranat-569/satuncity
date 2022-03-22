import 'package:flutter/material.dart';
import 'package:satuncity/screen/Login/login.dart';
import 'package:satuncity/screen/Login/splashscreen.dart';
import 'package:satuncity/screen/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  static const TextStyle ord = TextStyle(
      fontSize: 32.0,
      color: Color.fromRGBO(150, 222, 100, 1.0),
      fontFamily: "ChakraPetch");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (_) => Splashscreen(),
        '/home': (_) => Home(),
        '/login': (_) => LoginPage(),      },
      theme: ThemeData(fontFamily: 'ChakraPetch'),
    );
  }
}

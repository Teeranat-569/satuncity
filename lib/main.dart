import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:satuncity/screen/Login/login.dart';
import 'package:satuncity/screen/Login/splashscreen.dart';
import 'package:satuncity/screen/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async { 
  Intl.defaultLocale = "th";
  initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
 runApp(const ProviderScope(child: Myapp()));
 }

class Myapp extends StatelessWidget {
  const Myapp({Key key}) : super(key: key);

  static const TextStyle ord = TextStyle(
      fontSize: 32.0,
      color: Color.fromRGBO(150, 222, 100, 1.0),
      fontFamily: "ChakraPetch");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (_) => Splashscreen(),
        '/home': (_) => Home(),
        '/login': (_) => LoginPage(),
        // '/login': (_) => EditPage(),
                // '/login': (_) => AddTravel(),


      },
      theme: ThemeData(fontFamily: 'ChakraPetch'),
    );
  }
}

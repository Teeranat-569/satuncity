import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';
import 'package:satuncity/screen/OTOP.dart';
import 'package:satuncity/screen/Other.dart';
import 'package:satuncity/screen/conterller/auth_controller.dart';
import 'package:satuncity/screen/homedata.dart';
import 'package:satuncity/screen/travel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthController _authController;
  List<Widget> page = [Homedata(), Travel(), Otop(), Other()];

  int a = 0;
  var text = ["SATUN CITY...", "แนะนำสถานที่ท่องเที่ยว", "สินค้าOTOP", "อื่นๆ"];

  void b(int x) {
    setState(() {
      a = x;
      //print(x);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(children: [
          SafeArea(
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text("ออกจากระบบ"),
              onTap: () => _authController.logout(),
            ),
          ),
          Divider()
        ]),
      ),
      appBar: AppBar(
        title: Text(
          text[a],
          style: TextStyle(fontSize: 30.0),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(149, 200, 215, 1.0),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: b,
        currentIndex: a,
        selectedItemColor: Colors.red,
        iconSize: 40.0,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: new Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(
              icon: new Icon(Icons.flight_takeoff), label: "ท่องเที่ยว"),
          BottomNavigationBarItem(icon: new Icon(Icons.store), label: "OTOP"),
          BottomNavigationBarItem(
              icon: new Icon(Icons.drag_indicator), label: "อื่นๆ"),
        ],
      ),
      body: SafeArea(
          child: Center(
        child: page[a],
      )),
    );
  }
}

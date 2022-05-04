// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:satuncity/drawer.dart';
import 'package:satuncity/screen/Other.dart';
import 'package:satuncity/screen/homedata.dart';
import 'package:satuncity/screen/Otop/otop_page.dart';
import 'package:satuncity/screen/main_page.dart';
import 'package:satuncity/screen/travel.dart';

import 'Login/login.dart';

class Home extends StatefulWidget {
  dynamic username,email;
  Home({Key key, this.username,this.email}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> page = [BannerSlider(), Travel(), OtopPage(), Other()];

  int a = 0;
  var text = [
    "สตูล (SATUN)",
    "แนะนำสถานที่ท่องเที่ยว",
    "สินค้า OTOP",
    "อื่นๆ"
  ];

  void b(int x) {
    setState(() {
      a = x;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
          text[a],
          style: TextStyle(
              fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold),
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
          BottomNavigationBarItem(icon: new Icon(Icons.home), label: "หน้าหลัก"),
          BottomNavigationBarItem(
              icon: new Icon(Icons.flight_takeoff), label: "ท่องเที่ยว"),
          BottomNavigationBarItem(icon: new Icon(Icons.store), label: "สินค้า OTOP"),
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

// Alert ลงชื่อออกจากระบบ //////////////////////////////////////////////////////////////////////
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              title: const Text(
                'ลงชื่อออก',
              ),
              content: const Text('คุณต้องการลงชื่อออกหรือไม่?'),
              actions: <Widget>[
                cancleButton(),
                okButton(),
              ]);
        });
  }

// ปุ่มยกเลิก //////////////////////////////////////////////////////////////////////
  Widget cancleButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      color: Colors.grey[200],
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text(
        'ยกเลิก',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

// ปุ่มตกลง //////////////////////////////////////////////////////////////////////
  Widget okButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        signOut();
      },
      child: const Text(
        'ตกลง',
        style: TextStyle(color: Colors.green),
      ),
    );
  }

  // ออกจากระบบ //////////////////////////////////////////////////////////////////////
  Future<void> signOut() async {
    // ignore: avoid_print
    print('SIgnOut>>>>>>>>>>>>>>>>>>>>successssssssss');
    await FirebaseAuth.instance.signOut();
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => LoginPage());
    await Navigator.of(context)
        .pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
    Fluttertoast.showToast(
      msg: "ออกจากระบบ",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Color.fromARGB(255, 5, 3, 3),
    );
  }

// เปลี่ยนหน้า //////////////////////////////////////////////////////////////////////
  Future<Null> route(Widget routeName) async {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    await Navigator.of(context).push(materialPageRoute);
  }

 Future<Null> routeMove(Widget routeName) async {
   MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    await Navigator.of(context)
        .pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
  }
 

}

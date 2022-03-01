import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';
import 'package:satuncity/screen/Login/login.dart';
import 'package:satuncity/screen/OTOP.dart';
import 'package:satuncity/screen/Other.dart';
import 'package:satuncity/screen/TRAVEL/sea.dart';
import 'package:satuncity/screen/conterller/auth_controller.dart';
import 'package:satuncity/screen/homedata.dart';
import 'package:satuncity/screen/otop_page.dart';
import 'package:satuncity/screen/travel.dart';
import 'package:url_launcher/url_launcher.dart';

import 'admin/admin.dart';

class Home extends StatefulWidget {
  String username;
  Home({Key key, this.username}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // AuthController _authController;
  List<Widget> page = [Homedata(), Travel(), OtopPage(), Other()];
  List<Widget> pageAdmin = [Admin(), Sea()];

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
              onTap: () => myAlert(),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 10,
          ),
          // if (widget.username == 'satuncity-app@gmail.com')
          listMenu(Icon(Icons.add), 'เพิ่มข้อมูลสถานที่', 0),
          listMenu(Icon(Icons.edit), 'แก้ไขข้อมูลสถานที่', 1)
        ]),
      ),
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

  Widget listMenu(Icon icon, String title, int admin) {
    return ListTile(
      leading: icon,
      title: Text(title),
      onTap: () {
        route(pageAdmin[admin]);
        // _launchURL('https://goo.gl/maps/eEgoNRvepKtraS1U9');
      },
    );
  }

  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  Future<Null> route(Widget routeName) async {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    await Navigator.of(context).push(materialPageRoute);
  }

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
}

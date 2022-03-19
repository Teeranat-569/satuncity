import 'package:flutter/material.dart';
import 'package:satuncity/screen/Other.dart';
import 'package:satuncity/screen/admin/edit/edit_page.dart';
import 'package:satuncity/screen/homedata.dart';
import 'package:satuncity/screen/Otop/otop_page.dart';
import 'package:satuncity/screen/travel.dart';

import '../tes.dart';
import 'admin/admin.dart';

class Home extends StatefulWidget {
  String username;
  Home({Key key, this.username}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> page = [Homedata(), Travel(), OtopPage(), Other()];
  List<Widget> pageAdmin = [Admin(), EditPage()];

  int a = 0;
  var text = [
    "SATUN CITY...",
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
      drawer: Drawer(
        child: Column(children: [
          SafeArea(
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text("ออกจากระบบ"),
              onTap: () => Style().myAlert(),
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
          BottomNavigationBarItem(icon: new Icon(Icons.home), label: "Home"),
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
        Style().route(pageAdmin[admin]);
      },
    );
  }
}

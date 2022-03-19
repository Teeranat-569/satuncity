import 'package:flutter/material.dart';
import 'package:satuncity/screen/admin/add_festival.dart';
import 'package:satuncity/screen/admin/add_travel.dart';
import 'package:satuncity/screen/admin/add_otop.dart';
import 'package:satuncity/screen/admin/add_restaurant.dart';

import '../../tes.dart';
import 'edit/edit_page.dart';

class Admin extends StatefulWidget {
  const Admin({Key key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  List<Widget> pageAdmin = [Admin(), EditPage()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            listMenu(Icon(Icons.add), 'เพิ่มข้อมูลสถานที่', 0),
            listMenu(Icon(Icons.edit), 'แก้ไขข้อมูลสถานที่', 1)
          ]),
        ),
        appBar: AppBar(
          title: Text('เพิ่มข้อมูลสถานที่'),
        ),
        body: Column(
          children: [
            cate("สถานที่ท่องเที่ยว", AddTravel(), "images/sea1.jpg"),
            Padding(padding: EdgeInsets.only(bottom: 12.0)),
            cate("สินค้า OTOP", AddOtop(), "images/sea1.jpg"),
            Padding(padding: EdgeInsets.only(bottom: 12.0)),
            cate("ร้านอาหาร", Addrestaurant(), "images/sea1.jpg"),
            Padding(padding: EdgeInsets.only(bottom: 12.0)),
            cate("งานประจำปี", AddFestival(), "images/sea1.jpg"),
            Padding(padding: EdgeInsets.only(bottom: 12.0)),
          ],
        ),
      ),
    );
  }

  Widget cate(var text, Widget routeName, String pathIMG) {
    return InkWell(
      child: Container(
          height: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/hinngam.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(99, 0, 0, 0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )),
      onTap: () {
        Style().route(routeName);
      },
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

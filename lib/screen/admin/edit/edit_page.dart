import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:satuncity/screen/TRAVEL/SEA/sea_page.dart';
import 'package:satuncity/screen/admin/add_travel.dart';
import 'package:satuncity/screen/admin/add_otop.dart';
import 'package:satuncity/screen/admin/add_restaurant.dart';
import 'package:satuncity/screen/admin/edit/Otop/edit_otop_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../admin.dart';
import 'edit_travel.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  List<Widget> pageAdmin = [Admin(), EditPage()];
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
          listMenu(Icon(Icons.add), 'เพิ่มข้อมูลสถานที่', 0),
          listMenu(Icon(Icons.edit), 'แก้ไขข้อมูลสถานที่', 1)
        ]),
      ),
      appBar: AppBar(
        title: Text('แก้ไขข้อมูลสถานที่'),
      ),
      body: Column(
        children: [
          cate("สถานที่ท่องเที่ยว", EditTravel(), "images/sea1.jpg"),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
          cate("สินค้า OTOP", EditOtopPage(), "images/sea1.jpg"),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
          cate("ร้านอาหาร", Addrestaurant(), "images/sea1.jpg"),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
          cate("งานประจำปี", SeaPage(), "images/sea1.jpg"),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
        ],
      ),
    );
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
    // MaterialPageRoute materialPageRoute =
    //     MaterialPageRoute(builder: (BuildContext context) => LoginPage());
    // await Navigator.of(context)
    //     .pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
    Fluttertoast.showToast(
      msg: "ออกจากระบบ",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Color.fromARGB(255, 5, 3, 3),
    );
  }

  Widget cate(var text, Widget routeName, String pathIMG) {
    //ทะเล
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
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => routeName);
        Navigator.push(context, route);
      },
    );
  }

  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
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

  Future<Null> route(Widget routeName) async {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    await Navigator.of(context).push(materialPageRoute);
  }
}

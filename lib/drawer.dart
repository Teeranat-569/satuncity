
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:satuncity/screen/Login/login.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key key, this.email}) : super(key: key);
  String email;

      User user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Column(children: [
        const DrawerHeader(
          child: Center(
              child: Text(
            'ผู้ใช้งาน',
            style: TextStyle(fontSize: 50),
          )),
          decoration: BoxDecoration(color: Color.fromARGB(255, 150, 208, 255)),
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text(user.email),
          // onTap: () => myAlert(),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('หน้าหลัก'),
          onTap: () => routeMove(LoginPage(),context),
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Colors.red,
          ),
          title: Text("ออกจากระบบ"),
          onTap: () => myAlert(context),
        ),
        Divider(
          color: Colors.black,
          height: 10,
        ),
      ]),
    );
  }

  void myAlert(BuildContext context) {
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
                cancleButton(context),
                okButton(context),
              ]);
        });
  }

// ปุ่มยกเลิก //////////////////////////////////////////////////////////////////////
  Widget cancleButton(BuildContext context) {
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
  Widget okButton(BuildContext context) {
    // ignore: deprecated_member_use
    return FlatButton(
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        signOut(context);
      },
      child: const Text(
        'ตกลง',
        style: TextStyle(color: Colors.green),
      ),
    );
  }

  // ออกจากระบบ //////////////////////////////////////////////////////////////////////
  Future<void> signOut(BuildContext context) async {
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

   Future<Null> routeMove(Widget routeName, BuildContext context) async {
   MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    await Navigator.of(context)
        .pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
  }
}

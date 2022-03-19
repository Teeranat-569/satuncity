import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'screen/Login/login.dart';

class Style {
  List yy = [];
  BuildContext context;
 

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

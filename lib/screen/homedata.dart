import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homedata extends StatefulWidget {
  @override
  _HomedataState createState() => _HomedataState();
}

class _HomedataState extends State<Homedata> {
  Widget imagegray() {
    //รูปโชว์
    return Container(
      padding: EdgeInsets.only(top: 15.0),
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Image.asset("images/aaa.jpg"),
    );
  }

  Widget imgtest() {
    //แนะนำที่เที่ยว
    return Container(
      width: 150.0,
      height: 300.0,
      child: Image.asset("images/mixfood.jpg"),
      //color: Colors.red,
    );
  }

  Widget imgtest2() {
    return Container(
      width: 150.0,
      height: 150.0,
      child: Image.asset("images/mixfood.jpg"),
      //color: Colors.red,
    );
  }

  Widget showfood() {
    return Column(children: [
      imgtest2(),
      Padding(padding: EdgeInsets.only(bottom: 12.0)),
      imgtest2()
    ]);
  }

  Widget showmenu() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [imgtest(), showfood()]);
  }

  Widget c() {
    return ListView(
      children: [
        imagegray(),
        Padding(padding: EdgeInsets.only(top: 20.0)),
        showmenu()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: c());
  }
}

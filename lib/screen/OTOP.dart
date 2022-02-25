import 'package:flutter/material.dart';
import 'package:satuncity/screen/Otop/buda.dart';
import 'package:satuncity/screen/Otop/crochet.dart';
import 'package:satuncity/screen/Otop/otoppu.dart';
import 'package:satuncity/screen/Otop/semang.dart';

class Otop extends StatefulWidget {
  @override
  _OtopState createState() => _OtopState();
}

class _OtopState extends State<Otop> {
  Widget imgpu(var text) {
    //ขนมผูกรัก
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/p1.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Otoppu());
        Navigator.push(context, route);
      },
    );
  }

  Widget imgbuda(var text) {
    //ขนมบุหงาบุดะ
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/buda1.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Buda());
        Navigator.push(context, route);
      },
    );
  }

  Widget imgsemang(var text) {
    //ตุ๊กตาเซมัง
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/semang1.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Semang());
        Navigator.push(context, route);
      },
    );
  }

  Widget imgcrochet(var text) {
    //กระเป๋า
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/crochet1.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Crochet());
        Navigator.push(context, route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView(
        children: [
          imgpu("ขนมผูกรัก"),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
          imgbuda("ขนมบุหงาบุดะ"),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
          imgsemang("ตุ๊กตาเซมัง"),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
          imgcrochet("น้ำตกโตนปลิว")
        ],
      )),
    );
  }
}

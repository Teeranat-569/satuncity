import 'package:flutter/material.dart';
import 'package:satuncity/screen/Food/choice.dart';
import 'package:satuncity/screen/Food/fasai.dart';
import 'package:satuncity/screen/Food/nalagu.dart';
import 'package:satuncity/screen/Food/nur.dart';

class Food2 extends StatefulWidget {
  @override
  _Food2State createState() => _Food2State();
}

class _Food2State extends State<Food2> {
  Widget imgnla(var text) {
    //ณ ละงู
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/nla.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Nalagu());
        Navigator.push(context, route);
      },
    );
  }

  Widget imgchoice(var text) {
    //ร้านทางเลือก
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/choice.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Choice());
        Navigator.push(context, route);
      },
    );
  }

  Widget imgfasai(var text) {
    //ร้านฟ้าใส
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/fasai.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Fasai());
        Navigator.push(context, route);
      },
    );
  }

  Widget imgnur(var text) {
    //ร้านณูร์
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/nurr.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Nur());
        Navigator.push(context, route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ร้านอาหาร")),
      body: Center(
          child: ListView(
        children: [
          imgnla("ร้าน ณ ละงู"),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
          imgchoice("ร้านทางเลือกเพื่อสุขภาพ"),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
          imgfasai("ร้านฟ้าใส"),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
          imgnur("ร้านณูร์")
        ],
      )),
    );
  }
}

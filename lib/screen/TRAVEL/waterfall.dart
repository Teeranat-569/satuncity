import 'package:flutter/material.dart';
import 'package:satuncity/screen/TRAVEL/waterfall/Thansawan.dart';
import 'package:satuncity/screen/TRAVEL/waterfall/thanplio.dart';
import 'package:satuncity/screen/TRAVEL/waterfall/tonplio.dart';
import 'package:satuncity/screen/TRAVEL/waterfall/wst.dart';

class Waterfall extends StatefulWidget {
  @override
  _WaterfallState createState() => _WaterfallState();
}

class _WaterfallState extends State<Waterfall> {
  Widget imgwst(var text) {
    //น้ำตกวังสายทอง
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/wst3.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Wst());
        Navigator.push(context, route);
      },
    );
  }

  Widget imgtp(var text) {
    //น้ำตกธารปลิว
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/tp1.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Thanplio());
        Navigator.push(context, route);
      },
    );
  }

  Widget imgts(var text) {
    //น้ำตกธารสวรรค์
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/ts1.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Thansawan());
        Navigator.push(context, route);
      },
    );
  }

  Widget imgtonp(var text) {
    //น้ำตกโตนปลิว
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/tonp1.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Tonplio());
        Navigator.push(context, route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("น้ำตก")),
      body: Center(
          child: ListView(
        children: [
          imgwst("น้ำตกวังสายทอง"),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
          imgtp("น้ำตกธารปลิว"),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
          imgts("น้ำตกธารสวรรค์"),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
          imgtonp("น้ำตกโตนปลิว")
        ],
      )),
    );
  }
}

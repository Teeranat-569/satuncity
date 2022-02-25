import 'package:flutter/material.dart';
import 'package:satuncity/screen/TRAVEL/mountain/Chetkhot.dart';
import 'package:satuncity/screen/TRAVEL/mountain/geopark.dart';
import 'package:satuncity/screen/TRAVEL/mountain/stegodon.dart';
import 'package:satuncity/screen/TRAVEL/mountain/urai.dart';

class Mountain extends StatefulWidget {
  @override
  _MountainState createState() => _MountainState();
}

class _MountainState extends State<Mountain> {
  Widget imggeopark(var text) {
    //ถ้ำภูผาเพชร
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/geopark1.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Geopark());
        Navigator.push(context, route);
      },
    );
  }

  Widget imgchetkhot(var text) {
    //ถ้ำเจ็ดคต
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/chetkhot1.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Chetkhot());
        Navigator.push(context, route);
      },
    );
  }

  Widget imgstegodon(var text) {
    //ถ้ำเลสเตโกดอน
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/stegodon1.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Stegodon());
        Navigator.push(context, route);
      },
    );
  }

  Widget imgurai(var text) {
    //ถ้ำอุไรทอง
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/urai1.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Urai());
        Navigator.push(context, route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ภูเขา")),
      body: Center(
          child: ListView(
        children: [
          imggeopark("ถ้ำภูผาเพชร"),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
          imgchetkhot("ถ้ำเจ็ดคต"),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
          imgstegodon("ถ้ำเลสเตโกดอน"),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
          imgurai("ถ้ำอุไรทอง")
        ],
      )),
    );
  }
}

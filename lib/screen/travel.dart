import 'package:flutter/material.dart';
import 'package:satuncity/screen/TRAVEL/mountain.dart';
import 'package:satuncity/screen/TRAVEL/religious/Religiousplace.dart';
import 'package:satuncity/screen/TRAVEL/sea.dart';
import 'package:satuncity/screen/TRAVEL/waterfall.dart';

class Travel extends StatefulWidget {
  @override
  _TravelState createState() => _TravelState();
}

class _TravelState extends State<Travel> {
  Widget imgsea(var text) {
    //ทะเล
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/sea1.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Sea());
        Navigator.push(context, route);
      },
    );
  }

  Widget imgmountain(var text) {
    //ภูเขา mountain
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/mountain1.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Mountain());
        Navigator.push(context, route);
      },
    );
  }

  Widget imgwaterfall(var text) {
    //น้ำตก
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/wst1.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Waterfall());
        Navigator.push(context, route);
      },
    );
  }

  Widget imgreligious(var text) {
    //ศาสนสถาน
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/Religious.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
            builder: (BuildContext context) => Religiousplace());
        Navigator.push(context, route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          /*mainAxisSize: MainAxisSize.max,*/
          children: [
            imgsea("ทะเล"),
            Padding(padding: EdgeInsets.only(bottom: 12.0)),
            imgmountain("ภูเขา"),
            Padding(padding: EdgeInsets.only(bottom: 12.0)),
            imgwaterfall("น้ำตก"),
            Padding(padding: EdgeInsets.only(bottom: 12.0)),
            imgreligious("ศาสนสถาน"),
          ],
        ),
      ),
    );
  }
}

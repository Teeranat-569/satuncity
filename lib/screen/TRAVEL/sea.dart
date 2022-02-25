import 'package:flutter/material.dart';
import 'package:satuncity/screen/TRAVEL/SEA/dragon.dart';
import 'package:satuncity/screen/TRAVEL/SEA/hinngam.dart';
import 'package:satuncity/screen/TRAVEL/SEA/lipe.dart';
import 'package:satuncity/screen/TRAVEL/SEA/pakbara.dart';

class Sea extends StatefulWidget {
  @override
  _SeaState createState() => _SeaState();
}

class _SeaState extends State<Sea> {
  Widget imglipe(var text) {
    //หลีเป๊ะ
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/lipe1.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Lipe());
        Navigator.push(context, route);
      },
    );
  }

  Widget imghinngam(var text) {
    //เกาะหินงาม
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/hinngam1.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Hinngam());
        Navigator.push(context, route);
      },
    );
  }

  Widget imgpakbara(var text) {
    //หาดปากบารา
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/pakbara1.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Pakbara());
        Navigator.push(context, route);
      },
    );
  }

  Widget imgdragon(var text) {
    //สันหลังมังกร
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset("images/dragon1.jpg"),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Dragon());
        Navigator.push(context, route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ทะเล"),
      ),
      body: Center(
          child: ListView(
        children: [
          imghinngam("เกาะหินงาม"),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
          imglipe("เกาะหลีเป๊ะ"),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
          imgpakbara("หาดปากบารา"),
          Padding(padding: EdgeInsets.only(bottom: 12.0)),
          imgdragon("สันหลังมังกร")
        ],
      )),
      // backgroundColor: Colors.black,
    );
  }
}

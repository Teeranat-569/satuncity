import 'package:flutter/material.dart';
import 'package:satuncity/screen/TRAVEL/SEA/dragon.dart';

class Measure extends StatefulWidget {
  @override
  _MeasureState createState() => _MeasureState();
}

class _MeasureState extends State<Measure> {
  /* Widget imgdrago(var text) {
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
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("วัด"),
      ),
    );
  }
}

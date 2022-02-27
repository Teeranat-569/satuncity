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
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Image.asset("images/mountain1.jpg"),
              )),
        ],
      ),
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
          height: 120,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/mountain.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Color.fromARGB(99, 0, 0, 0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
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
            Padding(padding: EdgeInsets.only(bottom: 12.0)),
          ],
        ),
      ),
    );
  }

  Widget cate(var text, Widget routeName, String pathIMG) {
    //ทะเล
    return InkWell(
      child: Container(
          height: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/hinngam.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(99, 0, 0, 0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => routeName);
        Navigator.push(context, route);
      },
    );
  }
}
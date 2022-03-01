import 'package:flutter/material.dart';
import 'package:satuncity/screen/TRAVEL/mountain.dart';
import 'package:satuncity/screen/TRAVEL/religious/Religiousplace.dart';
import 'package:satuncity/screen/TRAVEL/sea.dart';
import 'package:satuncity/screen/TRAVEL/waterfall.dart';

import 'TRAVEL/sea_page.dart';

class Travel extends StatefulWidget {
  @override
  _TravelState createState() => _TravelState();
}

class _TravelState extends State<Travel> {
  Widget imgsea(var text) {
    //ทะเล
    return InkWell(
      child: Container(
          height: 120,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/sea.jpg'),
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
        MaterialPageRoute route = MaterialPageRoute(
            builder: (BuildContext context) => SeaPage(
                  travelCate: text,
                ));
        Navigator.push(context, route);
      },
    );
  }

  Widget imgmountain(var text2) {
    //ภูเขา mountain
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
                  text2,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )),
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
            builder: (BuildContext context) => SeaPage(
                  travelCate: text2,
                ));
        Navigator.push(context, route);
      },
    );
  }

  Widget imgwaterfall(var text3) {
    //น้ำตก
    return InkWell(
      child: Container(
          height: 120,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/wst2.JPG'),
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
                  text3,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )),
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
            builder: (BuildContext context) => SeaPage(
                  travelCate: text3,
                ));
        Navigator.push(context, route);
      },
    );
  }

  Widget imgreligious(var text4) {
    //ศาสนสถาน
    return InkWell(
      child: Container(
          height: 120,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/pics_9525_8.jpg'),
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
                  text4,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )),
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
            builder: (BuildContext context) => SeaPage(
                  travelCate: text4,
                ));
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

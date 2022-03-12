import 'package:flutter/material.dart';

import 'TRAVEL/SEA/edit_sea_page.dart';
import 'TRAVEL/mountain/edit_mountain_page.dart';
import 'TRAVEL/religious/edit_region_page.dart';
import 'TRAVEL/waterfall/edit_waterfall_page.dart';


class EditTravel extends StatefulWidget {
  @override
  _EditTravelState createState() => _EditTravelState();
}

class _EditTravelState extends State<EditTravel> {
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
            builder: (BuildContext context) => EditSeaPage(
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
            builder: (BuildContext context) => MountainPage(
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
            builder: (BuildContext context) => WaterfallPage(
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
            builder: (BuildContext context) => RegionPage(
                  travelCate: text4,
                ));
        Navigator.push(context, route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('แก้ไขข้อมูลสถานที่ท่องเที่ยว'),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios),
        //   onPressed: () {
        //     MaterialPageRoute route =
        //         MaterialPageRoute(builder: (BuildContext context) => Home());
        //   },
        // ),
      ),
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

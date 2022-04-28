// ignore_for_file: non_constant_identifier_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Homedata extends StatefulWidget {
  @override
  _HomedataState createState() => _HomedataState();
}

class _HomedataState extends State<Homedata> {
  List<String> yy = [];
  List<String> yyx = [];
  List<String> yyxx = [];
  List<String> yyxxx = [];

  List<String> gg = [];
  List<String> ggx = [];
  List<String> ggxx = [];

  List<String> name = [];
  List<dynamic> namell = [];
  List<String> namellg = [];
  dynamic indexx,
      index_r,
      travel_name,
      index_r2,
      indexxx,
      indexxxx,
      travel_namex,
      travel_namexx,
      index_rh,
      index_rx,
      index_rf,
      index_rfx,
      pic,
      otop_name,
      index_rhv;

  @override
  void initState() {
    readData();
    readDataTravel();
    readDataTravelWater();
    readDataOtop();
    super.initState();
  }

// แสดงข้อมูล //////////////////////////////////////////////////////////////////////
  readData() {
    FirebaseFirestore.instance
        .collection('travel')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          indexx = doc["pic"];
          travel_name = doc['travelName'];
          // yy = doc["pic"];
          // name.add(travel_name);
          yy.add(indexx);
        });
        print('ssssssssssssssssssssssssssss  ${yy.length}');
        print('sssssssssssssssss------------------sssssssssss  ${name.length}');
        print(
            'dddddd[[[[[[[[[[[[[[[[[[[[[[dddddddddddddddddddddddddddddddddd $indexx');
      });
    });
  }

  readDataTravel() {
    FirebaseFirestore.instance
        .collection('travel_mountain')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          indexxx = doc["pic"];
          travel_namex = doc['travelName'];
          // yy = doc["pic"];
          // name.add(travel_name);
          yyx.add(indexxx);
          gg.add(travel_namex);
        });
        print('fssssssssssssssssssss  ${yyx.length}');
        print('fffffffffffff  ${name.length}');
        print('ffffffffffffffffffdddddddddddddddddddd $indexxx');
      });
    });
  }

  readDataTravelWater() {
    FirebaseFirestore.instance
        .collection('travel_waterfall')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          indexxxx = doc["pic"];
          travel_namexx = doc['travelName'];
          // yy = doc["pic"];
          // name.add(travel_name);
          yyxx.add(indexxxx);
          ggx.add(travel_namexx);
        });
        print('fssssssssssssssssssss  ${yyxx.length}');
        // print('fffffffffffff  ${name.length}');
        print('ffffffffffffffffffdddddddddddddddddddd $indexxxx');
      });
    });
  }

  readDataOtop() {
    FirebaseFirestore.instance
        .collection('otop')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          pic = doc["otop_pic"];
          otop_name = doc['otop_name'];
          // yy = doc["pic"];
          // name.add(travel_name);
          yyxxx.add(pic);
          ggxx.add(otop_name);
        });
        print('fssssssssssssssssssss  ${yyxx.length}');
        // print('fffffffffffff  ${name.length}');
        print('ffffffffffffffffffdddddddddddddddddddd $indexxxx');
      });
    });
  }

  Widget imagegray() {
    //รูปโชว์
    return CarouselSlider(
      options: CarouselOptions(
          height: 200.0,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 10)),
      items: [
        for (var i = 0; i < yy.length; i++)
          {
            index_r = yy[i].toString(),
            print('dddddddddddddddddddddddddddddddddddddddd $index_r'),
          },
      ].map((j) {
        return Builder(
          builder: (BuildContext context) {
            List text = j.toList();
            print('gggggggggggggggggggg $text');
            return Container(
                width: MediaQuery.of(context).size.width,
                height: 500,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage("${text.join()}"))),
                child: Text(''));
          },
        );
      }).toList(),
    );
  }

  Widget image_mou() {
    //รูปโชว์
    return CarouselSlider(
      options: CarouselOptions(
          height: 200.0,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 6)),
      items: [
        for (var i = 0; i < yyx.length; i++)
          {
            index_rx = yyx[i].toString(),
            print('dddddddddddddddddddddddddddddddddddddddd $index_rx'),
          },
      ].map((j) {
        return Builder(
          builder: (BuildContext context) {
            List textx = j.toList();
            print('gggggggggggggggggggg $textx');
            return Container(
                width: MediaQuery.of(context).size.width,
                height: 500,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage("${textx.join()}"))),
                child: Text(''));
          },
        );
      }).toList(),
    );
  }

  Widget image_water() {
    //รูปโชว์
    return CarouselSlider(
      options: CarouselOptions(
          height: 200.0,
          autoPlay: true,
          reverse: true,
          autoPlayInterval: Duration(seconds: 12)),
      items: [
        for (var i = 0; i < yyxx.length; i++)
          {
            index_rf = yyxx[i].toString(),
            print('dddddddddddddddddddddddddddddddddddddddd $index_rf'),
          },
      ].map((j) {
        return Builder(
          builder: (BuildContext context) {
            List textx = j.toList();
            print('gggggggggggggggggggg $textx');
            return Container(
                width: MediaQuery.of(context).size.width,
                height: 500,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage("${textx.join()}"))),
                child: Text(''));
          },
        );
      }).toList(),
    );
  }

  Widget image_otop() {
    //รูปโชว์
    return CarouselSlider(
      options: CarouselOptions(
          height: 200.0,
          autoPlay: true,
          reverse: true,
          scrollDirection: Axis.vertical,
          autoPlayInterval: Duration(seconds: 15)),
      items: [
        for (var i = 0; i < yyxxx.length; i++)
          {
            index_rfx = yyxxx[i].toString(),
            print('dddddddddddddddddddddddddddddddddddddddd $index_rfx'),
          },
      ].map((j) {
        return Builder(
          builder: (BuildContext context) {
            List textx = j.toList();
            print('gggggggggggggggggggg $textx');
            return Container(
                width: MediaQuery.of(context).size.width,
                height: 500,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage("${textx.join()}"))),
                child: Text(''));
          },
        );
      }).toList(),
    );
  }

  Widget imgtest() {
    //แนะนำที่เที่ยว
    return Container(
      width: 150.0,
      height: 300.0,
      child: Image.asset("images/mixfood.jpg"),
    );
  }

  Widget imgtest2() {
    return Container(
      width: 150.0,
      height: 150.0,
      child: Image.asset("images/mixfood.jpg"),
    );
  }

  Widget showfood() {
    return Column(children: [
      imgtest2(),
      Padding(padding: EdgeInsets.only(bottom: 12.0)),
      imgtest2()
    ]);
  }

  Widget showmenu() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [imgtest(), showfood()]);
  }

  Widget c() {
    return ListView(
      children: [
        imagegray(),
        Padding(padding: EdgeInsets.only(top: 20.0)),
        showmenu()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              children: [
          imagegray(),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.50,
                      height: 100,
                      child: image_mou()),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.50,
                      height: 100,
                      child: image_water()),
                ],
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: 205,
                  color: Colors.blue.shade100,
                  child: Center(
                      child: Text(
                    'สถานที่ท่องเที่ยว',
                    style: TextStyle(fontSize: 20),
                  )))
            ],
          ),
          Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: 205,
                  color: Colors.pink.shade100,
                  child: Center(
                      child: Text(
                    'สินค้า Otop',
                    style: TextStyle(fontSize: 20),
                  ))),
              Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.50,
                      height: 200,
                      child: image_otop()),
                ],
              ),
            ],
          )
              ],
            ),
        ));
  }
}

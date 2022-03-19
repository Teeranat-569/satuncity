import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:satuncity/tes.dart';

class Homedata extends StatefulWidget {
  @override
  _HomedataState createState() => _HomedataState();
}

class _HomedataState extends State<Homedata> {
  List<String> yy = [];
  List<String> name = [];
  dynamic indexx, index_r, travel_name, index_r2;

  @override
  void initState() {
    readData();
    super.initState();
  }

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
          name.add(travel_name);
          yy.add(indexx);
        });
        print('ssssssssssssssssssssssssssss  ${yy.length}');
        print('sssssssssssssssss------------------sssssssssss  ${name.length}');
        print(
            'dddddd[[[[[[[[[[[[[[[[[[[[[[dddddddddddddddddddddddddddddddddd $indexx');
      });
    });
  }

  Widget imagegray() {
    //รูปโชว์
    return CarouselSlider(
      options: CarouselOptions(height: 200.0, autoPlay: true),
      items: [
        // yy,
        // print('gggggggggggggggggggg $indexx'),
        // print('555555555555555555555555  ${yy.length}')

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
                child:
                    // Image.network(
                    //   text.join(),
                    //   fit: BoxFit.cover,
                    // )
                    Text(text.join()));
                //     CarouselSlider(
                //   options: CarouselOptions(height: 200.0, autoPlay: true),
                //   items: [
                //     // yy,
                //     // print('gggggggggggggggggggg $indexx'),
                //     // print('555555555555555555555555  ${yy.length}')

                   

                //     for (var u = 0; u < name.length; u++)
                //       {
                //         index_r2 = name[u].toString(),
                //         print(
                //             'dddddddddddddddddddddddddddddddddddddddd $index_r'),
                //       }
                //   ].map((jj) {
                //     return Builder(
                //       builder: (BuildContext context) {
                //         List text2 = jj.toList();
                //         print('gggggggggggggggggggg $text');

                //         return Container(
                //             width: MediaQuery.of(context).size.width,
                //             height: 500,
                //             margin: const EdgeInsets.symmetric(horizontal: 5.0),
                //             decoration: BoxDecoration(
                //                 color: Colors.grey,
                //                 // image: new DecorationImage(
                //                 //     fit: BoxFit.fill,
                //                 //     image: new NetworkImage("${text.join()}"))
                //                     ),
                //             child:
                //                 // Image.network(
                //                 //   text.join(),
                //                 //   fit: BoxFit.cover,
                //                 // )
                //                 Text(text2.join()));
                //       },
                //     );
                //   }).toList(),
                // ));
          },
        );
      }).toList(),
    );
    Container(
      padding: EdgeInsets.only(top: 15.0),
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Image.asset("images/aaa.jpg"),
    );
  }

  Widget imgtest() {
    //แนะนำที่เที่ยว
    return Container(
      width: 150.0,
      height: 300.0,
      child: Image.asset("images/mixfood.jpg"),
      //color: Colors.red,
    );
  }

  Widget imgtest2() {
    return Container(
      width: 150.0,
      height: 150.0,
      child: Image.asset("images/mixfood.jpg"),
      //color: Colors.red,
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
    return Scaffold(body: c());
  }
}

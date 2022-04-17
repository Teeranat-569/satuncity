// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:satuncity/screen/TRAVEL/post.dart';
import 'package:url_launcher/url_launcher.dart';

class RegionData extends StatefulWidget {
  dynamic travelName, travelCate,url;
  RegionData({Key key, this.travelName, this.travelCate,this.url}) : super(key: key);
  @override
  _RegionDataState createState() => _RegionDataState();
}

class _RegionDataState extends State<RegionData> {
  dynamic travelName, travelCate, positive, travelMap;
  dynamic url;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('travel_region').snapshots();
  CollectionReference users =
      FirebaseFirestore.instance.collection('travel_region');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }

        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.travelName),
                 actions: [
                Center(
                  child: RaisedButton(
                    color: Colors.blue.shade700,
                      child: Text(
                        "รีวิว",
                        style: TextStyle(
                          color: Colors.white,
                          // fontSize: 20,
                          // fontWeight: FontWeight.w500,
                          fontFamily: 'Yaldevi',
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Post(
                                travelName: widget.travelName,
                                picUrl: widget.url,
                              ),
                            ));
                        print('555555555555555555555555' + widget.travelName);
                        print('4444444444444444444' + widget.url);
                      }),
                ),
              ],
            ),
            // ignore: avoid_unnecessary_containers
            body: Container(
              // แสดงข้อมูล //////////////////////////////////////////////////////////////////////
              child: ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  data["docid"] = document.id;
                  travelName = data['travelName'];
                  travelCate = data['travelCate'];
                  positive = data['positive'];
                  travelMap = data['travel_map'];
                  url = data['pic'].toString();

                  // ignore: avoid_print
                  print('4444444444444444444444444 ${data["docid"]}');
                  print('4444444444444444444444444 ${data["travelCate"]}');
                  return Center(
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 10)),
                        if (data['travelCate'] == widget.travelCate &&
                            data['travelName'] == widget.travelName)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(url),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.green,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'ลักษณะเด่น',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Container(
                                  child: Text(positive),
                                  width: 320,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.green,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'พิกัด',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        launchMap(data['travel_map']);
                                      },
                                      child: Text('คลิกเพื่อดูแผนที่')),
                                  IconButton(
                                      icon: Icon(Icons.directions),
                                      onPressed: () {
                                        launchMap(data['travel_map']);
                                      }),
                                ],
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

// แสดงแผนที่ //////////////////////////////////////////////////////////////////////
  void launchMap(travelMap) async {
    if (await canLaunch(travelMap)) {
      print("Can launch");

      await launch(travelMap);
    } else {
      print("Could not launch");
      throw 'Could not launch Maps';
    }
  }
}

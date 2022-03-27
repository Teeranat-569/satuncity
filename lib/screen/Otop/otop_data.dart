// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:satuncity/screen/Otop/store_page.dart';

class OtopData extends StatefulWidget {
  dynamic otopName;
  OtopData({Key key, this.otopName}) : super(key: key);
  @override
  _OtopDataState createState() => _OtopDataState();
}

class _OtopDataState extends State<OtopData> {
  dynamic otopName, otopData, otopMap, otopAdddress;
  dynamic url;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('otop').snapshots();
  CollectionReference users = FirebaseFirestore.instance.collection('otop');
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

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.otopName),
            backgroundColor: Colors.indigo,
          ),
          // ignore: avoid_unnecessary_containers
          body: Container(
            child: ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                data["docid"] = document.id;
                otopName = data['otop_name'];
                otopData = data['otop-data'];
                // otopMap = data['otop_map'];
                otopAdddress = data['otop_address'];
                url = data['otop_pic'].toString();

                // ignore: avoid_print
                print('4444444444444444444444444 ${data["docid"]}');
                print('4444444444444444444444444 ${data["otop_name"]}');
                return Center(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10)),
                      if (data['otop_name'] == widget.otopName)
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
                                  color: Colors.indigo,
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
                              child: Text(otopData),
                            ),
                              Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.indigo,
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'ร้านขายสินค้า',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                             Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [  IconButton(
                                      icon: Icon(Icons.store),
                                      onPressed: () {
                                        // launchMap(data['travel_map']);
                                      }),
                                  TextButton(
                                      onPressed: () {
                                        // launchMap(data['travel_map']);
                                         MaterialPageRoute route = MaterialPageRoute(
                                  builder: (BuildContext context) => StorePage(
                                        otopName: data['otop_name'],
                                      ));
                              Navigator.push(context, route);
                                      },
                                      child: Text('คลิกเพื่อดูร้านค้า')),
                                
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
        );
      },
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:satuncity/screen/Otop/store_otop.dart';

class StorePage extends StatefulWidget {
  dynamic otopName;
  StorePage({Key key, this.otopName}) : super(key: key);
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  dynamic storeName;
  dynamic url;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('otop_store').snapshots();
  CollectionReference users =
      FirebaseFirestore.instance.collection('otop_store');

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
            backgroundColor: Colors.indigo,
            title: Text('ร้านขายสินค้า "${widget.otopName}"'),
          ),
          // ignore: avoid_unnecessary_containers
          body: Container(
            // แสดงข้อมูล //////////////////////////////////////////////////////////////////////

            child: ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              data["docid"] = document.id;
              storeName = data['store_name'];
              // ignore: avoid_print
              print('4444444444444444444444444 ${data["docid"]}');
              print('4444444444444444444444444 ${data["store_name"]}');
              return Column(
                children: [
                  if (widget.otopName == data['otop_name'])
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey.shade200,
                        ),
                        width: MediaQuery.of(context).size.width,
                        // ignore: deprecated_member_use
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  child: Container(
                                    color: Colors.indigo,
                                    height: 50,
                                    width: 50,
                                    child: Icon(
                                      Icons.store,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                                InkWell(
                                  child: Container(
                                      height: 100,
                                      width: 300,
                                      child: Center(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          // color: Color.fromARGB(112, 11, 60, 75),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              data['store_name'],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      )),
                                  onTap: () {
                                    MaterialPageRoute route = MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            StoreOtop(
                                              storeName: data['store_name'],
                                            ));
                                    Navigator.push(context, route);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                ],
              );
            }).toList()),
          ),
        );
      },
    );
  }
}

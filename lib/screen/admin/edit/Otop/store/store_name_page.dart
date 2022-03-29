// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:satuncity/screen/admin/edit/Otop/store/edit_store_data.dart';

class StoreNamePage extends StatefulWidget {
  dynamic otopName;
  StoreNamePage({Key key, this.otopName}) : super(key: key);
  @override
  _StoreNamePageState createState() => _StoreNamePageState();
}

class _StoreNamePageState extends State<StoreNamePage> {
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
            backgroundColor: Color.fromARGB(255, 102, 38, 102),
            title: Text('ร้านขายสินค้า "${widget.otopName}"'),
          ),
          // ignore: avoid_unnecessary_containers
          body: Container(
            child: ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              data["docid"] = document.id;
              storeName = data['store_name'];
              print('4444444444444444444444444 ${data["docid"]}');
              print('4444444444444444444444444 ${data["store_name"]}');
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey.shade200,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      if (widget.otopName == data['otop_name'])
                        Row(
                          children: [
                            InkWell(
                              child: Container(
                                color: Color.fromARGB(255, 102, 38, 102),
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
                                  height: 50,
                                  width: 300,
                                  child: Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
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
                                        EditStoreData(
                                          storeName: data['store_name'],
                                          docid: data['docid'],
                                        ));
                                Navigator.push(context, route);
                              },
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              );
              // : Text('');
            }).toList()),
          ),
        );
      },
    );
  }
}

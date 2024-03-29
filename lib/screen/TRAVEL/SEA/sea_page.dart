// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:satuncity/drawer.dart';
import 'package:satuncity/screen/TRAVEL/SEA/sea_data.dart';

class SeaPage extends StatefulWidget {
  dynamic travelCate;
  SeaPage({Key key, this.travelCate}) : super(key: key);
  @override
  _SeaPageState createState() => _SeaPageState();
}

class _SeaPageState extends State<SeaPage> {
  dynamic travelName;
  dynamic travelCate;
  dynamic url;
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('travel')
      .where('travelCate')
      .orderBy('createdAt', descending: true)
      .snapshots();
  CollectionReference users = FirebaseFirestore.instance.collection('travel');

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
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Text('${widget.travelCate}'),
          ),
          // ignore: avoid_unnecessary_containers
          body: Container(
            child: ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                data["docid"] = document.id;
                travelName = data['travelName'];
                travelCate = data['travelCate'];
                url = data['pic'].toString();

                // ignore: avoid_print
                print('4444444444444444444444444 ${data["docid"]}');
                print('4444444444444444444444444 ${data["travelCate"]}');
                return Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey.shade200,
                    ),
                    width: MediaQuery.of(context).size.width,
                    // ignore: deprecated_member_use
                    child: Column(
                      children: [
                        if (travelCate == widget.travelCate)
                          InkWell(
                            child: Container(
                                height: 120,
                                decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new NetworkImage("$url"))),
                                child: Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: Color.fromARGB(99, 0, 0, 0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        data['travelName'],
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
                                  builder: (BuildContext context) => SeaData(
                                        travelName: data['travelName'],
                                        travelCate: data['travelCate'],
                                        url: data['pic'].toString(),
                                      ));
                              Navigator.push(context, route);
                            },
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'ไม่มีข้อมูล "${widget.travelCate}"',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          )
                      ],
                    ),
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

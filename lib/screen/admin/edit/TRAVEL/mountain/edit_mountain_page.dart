// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'edit_mountain_data.dart';

class EditMountainPage extends StatefulWidget {
  dynamic travelCate;
  EditMountainPage({Key key, this.travelCate}) : super(key: key);
  @override
  _EditMountainPageState createState() => _EditMountainPageState();
}

class _EditMountainPageState extends State<EditMountainPage> {
  dynamic travelName;
  dynamic travelCate;
  dynamic url;
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('travel_mountain')
      .where('travelCate')
      .snapshots();
  CollectionReference users =
      FirebaseFirestore.instance.collection('travel_mountain');

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
            title: Text('${widget.travelCate}'),
            backgroundColor: Color.fromARGB(255, 102, 38, 102),
          ),
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
                                  builder: (BuildContext context) =>
                                      EditMountainData(
                                        travelName: data['travelName'],
                                        travelCate: data['travelCate'],
                                        docid: data['docid'],
                                      ));
                              Navigator.push(context, route);
                            },
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'festival_data.dart';

class Festival extends StatefulWidget {
  @override
  _FestivalState createState() => _FestivalState();
}

class _FestivalState extends State<Festival> {
  dynamic resName;
 dynamic url;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('festival').snapshots();
  CollectionReference users = FirebaseFirestore.instance.collection('festival');

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
            backgroundColor: Colors.deepOrange.shade700,
            title: Text('งานประจำปี'),
          ),
          // ignore: avoid_unnecessary_containers
          body: Container(
            child: ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                data["docid"] = document.id;
                resName = data['fes_name'];
                // url = data['res_pic'].toString();

                // ignore: avoid_print
                print('4444444444444444444444444 ${data["docid"]}');
                print('4444444444444444444444444 ${data["fes_name"]}');
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
                        Row(
                          children: [
                            InkWell(
                              child: Container(
                                color: Colors.deepOrange.shade700,
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.festival,
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
                                      // color: Color.fromARGB(112, 11, 60, 75),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          data['fes_name'],
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
                                        FestivalData(
                                          fesName: data['fes_name'],
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
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

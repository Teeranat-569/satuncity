import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'edit_restaurant_data.dart';

class EditFoodPage extends StatefulWidget {
  @override
  _EditFoodPageState createState() => _EditFoodPageState();
}

class _EditFoodPageState extends State<EditFoodPage> {
  dynamic resName, url;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('restaurant').snapshots();
  CollectionReference users =
      FirebaseFirestore.instance.collection('restaurant');

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
            title: Text('ร้านอาหาร'),        backgroundColor: Color.fromARGB(255, 102, 38, 102),

          ),
          body: Container(
            child: ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                data["docid"] = document.id;
                resName = data['res_name'];
                url = data['res_pic'].toString();

                // ignore: avoid_print
                print('4444444444444444444444444 ${data["docid"]}');
                print('4444444444444444444444444 ${data["res_name"]}');
                return Padding(
                  padding: const EdgeInsets.all(10.0),
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
                                color: Colors.cyan,
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.restaurant,
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
                                      width: MediaQuery.of(context).size.width,
                                      color: Color.fromARGB(112, 11, 60, 75),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          data['res_name'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  )),
                              onTap: () {
                                MaterialPageRoute route = MaterialPageRoute(
                                    builder: (BuildContext context) => EditFoodData(
                                          resName: data['res_name'],
                                          docid:  data['docid'],
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

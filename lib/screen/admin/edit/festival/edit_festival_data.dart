// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:satuncity/loading/loading_screen.dart';
import 'package:satuncity/screen/admin/edit/edit_page.dart';

class EditFestivalData extends StatefulWidget {
  dynamic fesName, docid;
  EditFestivalData({Key key, this.fesName, this.docid}) : super(key: key);
  @override
  _EditFestivalDataState createState() => _EditFestivalDataState();
}

class _EditFestivalDataState extends State<EditFestivalData> {
  // ignore: non_constant_identifier_names
  dynamic fesName, fesData, fes_index, otopAdddress, edit_fesData, edit_fesname;
  dynamic url;
  List<dynamic> yy = [];
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController_2 = TextEditingController();

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('festival').snapshots();
  CollectionReference users = FirebaseFirestore.instance.collection('festival');
  var collection = FirebaseFirestore.instance.collection('festival');

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
            title: Text(widget.fesName),
            backgroundColor: Color.fromARGB(255, 102, 38, 102),
            actions: [
              TextButton(
                onPressed: () async {
                   LoadingScreen().show(
                  context: context,
                  text: 'Please wait a moment',
                );

                // await for 2 seconds to Mock Loading Data
                await Future.delayed(const Duration(seconds: 3));

                  try {
                    collection
                        .doc(widget
                            .docid) // <-- Doc ID where data should be updated.
                        .update({
                      'fes_name': textEditingController.text,
                      'fes_data': textEditingController_2.text,
                    });
                    Fluttertoast.showToast(
                      msg: "แก้ไขสำเร็จ",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.orange[100],
                      textColor: Colors.black,
                    );

                    print(
                        '7777777777777777777777777777${textEditingController.text}');
                  } on firebase_core.FirebaseException catch (e) {
                    // ignore: avoid_print
                    print(e);
                  }
                  MaterialPageRoute materialPageRoute = MaterialPageRoute(
                      builder: (BuildContext context) => EditPage());
                  Navigator.of(context).pushAndRemoveUntil(
                      materialPageRoute, (Route<dynamic> route) => false);
                                      LoadingScreen().hide();

                },
                child: Text(
                  'แก้ไข',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          // ignore: avoid_unnecessary_containers
          body: Container(
            child: ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                data["docid"] = document.id;
                fesName = data['fes_name'];
                fesData = data['fes_data'];

                yy = data['fes_pic'];
                // ignore: avoid_print
                print('4444444444444444444444444 ${data["docid"]}');
                print('4444444444444444444444444 ${data["fes_name"]}');
                return Center(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10)),
                      if (data['fes_name'] == widget.fesName)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                  height: 200.0, autoPlay: true),
                              items: [
                                for (var i = 0; i < yy.length; i++)
                                  {
                                    fes_index = data['fes_pic'][i].toString(),
                                    print(
                                        'dddddddddddddddddddddddddddddddddddddddd $fes_index'),
                                  }
                              ].map((j) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    List text = j.toList();

                                    print('gggggggggggggggggggg $text');

                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: const BoxDecoration(
                                            color: Colors.grey),
                                        child: Image.network(
                                          text.join(),
                                          fit: BoxFit.cover,
                                        ));
                                  },
                                );
                              }).toList(),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.deepOrange.shade800,
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'ชื่องานปรำจำปี',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: _editTitleTextField(
                                  data['fes_name'],
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.deepOrange.shade800,
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
                              padding:
                                  const EdgeInsets.only(left: 25, right: 10),
                              child: _editTitleTextField_2(
                                data['fes_data'],
                              ),
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

  Widget _editTitleTextField(
    dynamic kk,
  ) {
    textEditingController = TextEditingController(text: kk);

    return Container(
      child: Center(
        child: TextField(
          // maxLines: 10,

          controller: textEditingController,
        ),
      ),
    );
  }

  Widget _editTitleTextField_2(
    dynamic kk,
  ) {
    textEditingController_2 = TextEditingController(text: kk);

    return Container(
      child: Center(
        child: TextField(
          maxLines: 10,
          controller: textEditingController_2,
        ),
      ),
    );
  }
}

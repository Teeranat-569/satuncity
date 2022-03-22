// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import '../edit_page.dart';

// ignore: must_be_immutable
class EditFoodData extends StatefulWidget {
  dynamic resName, docid;
  EditFoodData({Key key, this.resName, this.docid}) : super(key: key);
  @override
  _EditFoodDataState createState() => _EditFoodDataState();
}

class _EditFoodDataState extends State<EditFoodData> {
  dynamic resName, resData, resMap, resAdddress, travelCate_index;
  dynamic url, pathPIC, edit_img;
  dynamic edit_positive, edit_map_url, edit_travelName, edit_url;

  // ignore: unused_field
  dynamic _image;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('restaurant').snapshots();
  CollectionReference users =
      FirebaseFirestore.instance.collection('restaurant');

  List<dynamic> yy = [];
  var collection = FirebaseFirestore.instance.collection('restaurant');

  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController_2 = TextEditingController();
  TextEditingController textEditingController_3 = TextEditingController();
  TextEditingController textEditingController_4 = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    textEditingController_2.dispose();
    textEditingController_3.dispose();
    textEditingController_4.dispose();
    super.dispose();
  }

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
              title: Text(widget.resName),
              actions: [
                TextButton(
                  onPressed: () async {
                    Random random = Random();
                    int i = random.nextInt(100000);
                    await firebase_core.Firebase.initializeApp();
                    final firebase_storage.FirebaseStorage storage =
                        firebase_storage.FirebaseStorage.instance;

                    if (pathPIC != null) {
                      File file = File(pathPIC);
                      try {
                        await storage
                            .ref('restaurant/restaurant_$i')
                            .putFile(file);
                        dynamic url2 = await storage
                            .ref('restaurant/restaurant_$i')
                            .getDownloadURL();
                        setState(() {
                          edit_img = url2;
                        });
                        collection
                            .doc(widget
                                .docid) // <-- Doc ID where data should be updated.
                            .update({
                          'res_name': textEditingController_4.text,
                          'res_map': textEditingController_3.text,
                          'res_data': textEditingController.text,
                          'res_address': textEditingController_2.text,
                        });
                        Fluttertoast.showToast(
                          msg: "แก้ไขสำเร็จ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.orange[100],
                          textColor: Colors.black,
                        );

                        print('7777777777777777777777777777$edit_img');
                        print(
                            '77777777777777777222222eeeeeeeeee222222277777777777$url2');
                      } on firebase_core.FirebaseException catch (e) {
                        // ignore: avoid_print
                        print(e);
                      }
                      MaterialPageRoute materialPageRoute = MaterialPageRoute(
                          builder: (BuildContext context) => EditPage());
                      Navigator.of(context).pushAndRemoveUntil(
                          materialPageRoute, (Route<dynamic> route) => false);
                    } else {
                      try {
                        collection
                            .doc(widget
                                .docid) // <-- Doc ID where data should be updated.
                            .update({
                          'res_name': textEditingController_4.text,
                          'res_map': textEditingController_3.text,
                          'res_data': textEditingController.text,
                          'res_address': textEditingController_2.text,
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
                    }
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
                  resName = data['res_name'];
                  resData = data['res-data'];
                  resMap = data['res_map'];
                  resAdddress = data['res_address'];
                  yy = data['res_pic'];
                  for (var i = 0; i < yy.length; i++) {
                    travelCate_index = data['res_pic'][i];
                    print(
                        'dddddddddddddddddddddddddddddddddddddddd $travelCate_index');
                  }
                  // ignore: avoid_print
                  print('4444444444444444444444444 ${data["docid"]}');
                  print('4444444444444444444444444 ${data["res_name"]}');
                  return Center(
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 5)),
                        if (data['res_name'] == widget.resName)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                      'รูปภาพ',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              CarouselSlider(
                                options: CarouselOptions(
                                    height: 200.0, autoPlay: true),
                                items: [
                                  for (var i = 0; i < yy.length; i++)
                                    {
                                      travelCate_index =
                                          data['res_pic'][i].toString(),
                                      print(
                                          'dddddddddddddddddddddddddddddddddddddddd $travelCate_index'),
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
                                    color: Colors.green,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'ชื่อร้านอาหาร',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child:
                                      _editTitleTextField_4(data['res_name'])),
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
                                  child: _editTitleTextField(data['res-data'])),
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
                                      'ที่อยู่ร้านอาหาร',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: _editTitleTextField_2(
                                      data['res_address'])),
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
                              Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child:
                                      _editTitleTextField_3(data['res_map'])),
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

  Widget _editTitleTextField(dynamic kk) {
    textEditingController = TextEditingController(text: kk);

    return Center(
      child: TextField(
        onSubmitted: (newValue) {
          setState(() {
            edit_travelName = newValue;
            // _isEditingText = false;
          });
        },
        controller: textEditingController,
      ),
    );
  }

  Widget _editTitleTextField_2(dynamic kk) {
    textEditingController_2 = TextEditingController(text: kk);

    return Center(
      child: TextField(
        onSubmitted: (newValue) {
          setState(() {
            edit_positive = newValue;
          });
        },
        controller: textEditingController_2,
      ),
    );
  }

  Widget _editTitleTextField_3(dynamic kk) {
    textEditingController_3 = TextEditingController(text: kk);

    return Center(
      child: TextField(
        onSubmitted: (newValue) {
          setState(() {
            edit_map_url = newValue;
          });
        },
        controller: textEditingController_3,
      ),
    );
  }

  Widget _editTitleTextField_4(dynamic kk) {
    textEditingController_4 = TextEditingController(text: kk);

    return Center(
      child: TextField(
        onSubmitted: (newValue) {
          setState(() {
            edit_url = newValue;
          });
        },
        controller: textEditingController_4,
      ),
    );
  }
}

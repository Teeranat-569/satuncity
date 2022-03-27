// ignore_for_file: must_be_immutable, non_constant_identifier_names, unused_element

import 'dart:io';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:satuncity/screen/admin/edit/edit_page.dart';

class EditStoreData extends StatefulWidget {
  dynamic storeName, docid;
  EditStoreData({Key key, this.storeName, this.docid}) : super(key: key);
  @override
  _EditStoreDataState createState() => _EditStoreDataState();
}

class _EditStoreDataState extends State<EditStoreData> {
  dynamic storeName,
      storeAddress,
      storeMap,
      storeAdddress,
      pathPIC,
      line,
      facebook,
      store_index,
      website;
  List url;
  dynamic edit_storeName,
      edit_storeAddress,
      edit_storeMap,
      edit_img,
      edit_facebook,
      edit_Line,
      edit_website,
      edit_phone;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('otop_store').snapshots();
  CollectionReference users =
      FirebaseFirestore.instance.collection('otop_store');
  var collection = FirebaseFirestore.instance.collection('otop_store');
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController_2 = TextEditingController();
  TextEditingController textEditingController_3 = TextEditingController();

  TextEditingController textEditingController_4 = TextEditingController();
  TextEditingController textEditingController_5 = TextEditingController();
  TextEditingController textEditingController_6 = TextEditingController();
  TextEditingController textEditingController_7 = TextEditingController();
  TextEditingController textEditingController_8 = TextEditingController();
  TextEditingController textEditingController_9 = TextEditingController();
  @override
  void dispose() {
    textEditingController.dispose();
    textEditingController_2.dispose();
    textEditingController_3.dispose();
    textEditingController_4.dispose();
    textEditingController_5.dispose();
    textEditingController_6.dispose();
    textEditingController_7.dispose();
    textEditingController_8.dispose();
    textEditingController_9.dispose();
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
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.storeName),
            backgroundColor: Color.fromARGB(255, 102, 38, 102),
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
                      await storage.ref('otop/otop_$i').putFile(file);
                      dynamic url2 =
                          await storage.ref('otop/otop_$i').getDownloadURL();
                      setState(() {
                        edit_img = url2;
                      });
                      collection
                          .doc(widget
                              .docid) // <-- Doc ID where data should be updated.
                          .update({
                        'otop_name': textEditingController.text,
                        // 'travel_map': t,
                        'otop-data': textEditingController_2.text,
                        'otop_pic': edit_img,
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
                        'store_name': textEditingController.text,
                        'store_address': textEditingController_2.text,
                        'store_phone': textEditingController_3.text,
                        'store_map': textEditingController_4.text,
                        'store_facebook': textEditingController_5.text,
                        'store_Line': textEditingController_6.text,
                        'store_website': textEditingController_7.text,
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
                storeName = data['store_name'];
                storeAddress = data['store_phone'];
                storeMap = data['store_map'];
                storeAdddress = data['store_address'];
                line = data['store_Line'];
                facebook = data['store_facebook'];
                website = data['store_website'];
                url = data['store_pic'];
                for (var i = 0; i < url.length; i++) {
                  store_index = data['store_pic'][i];
                  print(
                      'dddddddddddddddddddddddddddddddddddddddd $store_index');
                }
                // ignore: avoid_print
                print('4444444444444444444444444 ${data["docid"]}');
                print('4444444444444444444444444 ${data["otop_name"]}');
                return Center(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10)),
                      if (data['store_name'] == widget.storeName)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                  height: 200.0, autoPlay: true),
                              items: [
                                for (var i = 0; i < url.length; i++)
                                  {
                                    store_index =
                                        data['store_pic'][i].toString(),
                                    print(
                                        'dddddddddddddddddddddddddddddddddddddddd $store_index'),
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
                            topics('ชือร้าน'),
                            Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: _editTitleTextField(data['store_name'],
                                    edit_storeName, textEditingController)),
                            topics('ที่อยู่'),
                            Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: _editTitleTextField(
                                    data['store_address'],
                                    edit_storeAddress,
                                    textEditingController_2)),
                            topics('เบอร์โทร'),
                            Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: _editTitleTextField(data['store_phone'],
                                    edit_phone, textEditingController_3)),
                            topics('Google Map'),
                            Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: _editTitleTextField(data['store_map'],
                                    edit_storeMap, textEditingController_4)),
                            topics('Facebook'),
                            Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: _editTitleTextField(
                                    data['store_facebook'],
                                    edit_facebook,
                                    textEditingController_5)),
                            topics('Line'),
                            Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: _editTitleTextField(data['store_Line'],
                                    edit_Line, textEditingController_6)),
                            topics('Website'),
                            Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: _editTitleTextField(data['store_website'],
                                  edit_website, textEditingController_7),
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

  Padding topics(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color.fromARGB(255, 102, 38, 102),
        ),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _editTitleTextField(
      dynamic kk, value, TextEditingController controller) {
    controller = TextEditingController(text: kk);

    return Center(
      child: TextField(
        onSubmitted: (newValue) {
          setState(() {
            value = newValue;
            // _isEditingText = false;
          });
        },
        controller: controller,
      ),
    );
  }


 
}

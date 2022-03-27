// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import '../edit_page.dart';

class EditOtopData extends StatefulWidget {
  dynamic otopName, docid;
  EditOtopData({Key key, this.otopName, this.docid}) : super(key: key);
  @override
  _EditOtopDataState createState() => _EditOtopDataState();
}

class _EditOtopDataState extends State<EditOtopData> {
  dynamic otopName, otopData, otopMap, otopAdddress, pathPIC;
  dynamic url, edit_otopName, edit_otopData, edit_otopMap;
  dynamic _image, edit_img;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('otop').snapshots();
  CollectionReference users = FirebaseFirestore.instance.collection('otop');
  var collection = FirebaseFirestore.instance.collection('otop');
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController_2 = TextEditingController();
  TextEditingController textEditingController_3 = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    textEditingController_2.dispose();
    textEditingController_3.dispose();
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
            title: Text(widget.otopName),
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
                        'otop_name': textEditingController.text,
                        // 'travel_map': t,
                        'otop-data': textEditingController_2.text,
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
            // color: Colors.purple[50],
            child: ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                data["docid"] = document.id;
                otopName = data['otop_name'];
                otopData = data['otop-data'];
                otopMap = data['otop_map'];
                // otopAdddress = data['otop_address'];
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                showImage(),
                                IconButton(
                                    onPressed: () {
                                      getImage();
                                    },
                                    icon: const Icon(
                                      Icons.file_upload,
                                      size: 40,
                                    )),
                              ],
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
                                    'ชื่อสินค้า',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: _editTitleTextField(data['otop_name'])),
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
                                child:
                                    _editTitleTextField_2(data['otop-data'])),
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

  Widget showImage() {
    return Container(
        decoration: BoxDecoration(
            // color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        width: 250.0,
        height: 150.0,
        child: _image == null
            ? ClipRect(
                child:
                    InteractiveViewer(maxScale: 20, child: Image.network(url)))
            : ClipRect(
                child: InteractiveViewer(
                    maxScale: 20, child: Image.file(_image))));
  }

  Future getImage() async {
    final pickedFile =
        // ignore: deprecated_member_use
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        pathPIC = pickedFile.path;
        print('ffffffffffffffffffffffffffffs' + pathPIC);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget _editTitleTextField(dynamic kk) {
    textEditingController = TextEditingController(text: kk);

    return Center(
      child: TextField(
        onSubmitted: (newValue) {
          setState(() {
            edit_otopName = newValue;
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
            edit_otopData = newValue;
          });
        },
        controller: textEditingController_2,
      ),
    );
  }
}

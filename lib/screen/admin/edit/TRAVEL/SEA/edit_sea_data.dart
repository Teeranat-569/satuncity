import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:satuncity/screen/admin/edit/TRAVEL/SEA/edit_sea_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class EditSeaData extends StatefulWidget {
  dynamic travelName, travelCate, docid;
  EditSeaData({Key key, this.travelName, this.travelCate, this.docid})
      : super(key: key);
  @override
  _EditSeaDataState createState() => _EditSeaDataState();
}

class _EditSeaDataState extends State<EditSeaData> {
  dynamic travelName, travelCate, positive, travelMap, pathPIC;
  String url, edit_positive, edit_map_url, edit_travelName;
  dynamic _image, edit_img;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('travel').snapshots();
  CollectionReference users = FirebaseFirestore.instance.collection('travel');
  var collection = FirebaseFirestore.instance.collection('travel');

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
              title: Text(widget.travelName),
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
                        await storage.ref('travel/travel_sea_$i').putFile(file);
                        dynamic url2 = await storage
                            .ref('travel/travel_sea_$i')
                            .getDownloadURL();
                        setState(() {
                          edit_img = url2;
                        });
                        collection
                            .doc(widget
                                .docid) // <-- Doc ID where data should be updated.
                            .update({
                          'travelName': edit_travelName,
                          'travel_map': edit_map_url,
                          'positive': edit_positive,
                          'pic': edit_img,
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
                          builder: (BuildContext context) => EditSeaPage());
                      Navigator.of(context).pushAndRemoveUntil(
                          materialPageRoute, (Route<dynamic> route) => false);
                    } else {
                      try {
                        collection
                            .doc(widget
                                .docid) // <-- Doc ID where data should be updated.
                            .update({
                          'travelName': edit_travelName,
                          'travel_map': edit_map_url,
                          'positive': edit_positive,
                        });
                        Fluttertoast.showToast(
                          msg: "แก้ไขสำเร็จ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.orange[100],
                          textColor: Colors.black,
                        );

                        print('7777777777777777777777777777$edit_img');
                      } on firebase_core.FirebaseException catch (e) {
                        // ignore: avoid_print
                        print(e);
                      }
                      MaterialPageRoute materialPageRoute = MaterialPageRoute(
                          builder: (BuildContext context) => EditSeaPage());
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
                  travelName = data['travelName'];
                  travelCate = data['travelCate'];
                  positive = data['positive'];
                  travelMap = data['travel_map'];
                  url = data['pic'].toString();

                  // ignore: avoid_print
                  print('4444444444444444444444444 ${data["docid"]}');
                  print('4444444444444444444444444 ${data["travelCate"]}');
                  print('4444444444444444444444444 ${data["travelName"]}');
                  return Center(
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 10)),
                        if (data['travelCate'] == widget.travelCate &&
                            data['travelName'] == widget.travelName)
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
                                      'ชื่อสถานที่',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: TextField(
                                  controller:
                                      TextEditingController(text: travelName),
                                  onChanged: (text) {
                                    print('First text field: $text');

                                    edit_travelName == null
                                        ? edit_travelName = data['travelName']
                                        : edit_travelName = text;
                                  },
                                ),
                              ),
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
                                child: TextField(
                                  maxLines: 10,
                                  controller:
                                      TextEditingController(text: positive),
                                  onChanged: (text) {
                                    print('First text field: $text');

                                    edit_positive == null
                                        ? edit_positive = data['positive']
                                        : edit_positive = text;
                                  },
                                ),
                              ),
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
                                child: TextField(
                                  controller: TextEditingController(
                                      text: data['travel_map']),
                                  onChanged: (text) {
                                    print('First text field: $text');

                                    if (edit_map_url == null) {
                                      edit_map_url = data['travel_map'];
                                    } else {
                                      edit_map_url = text;
                                    }
                                  },
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
          ),
        );
      },
    );
  }

  //method to launch maps
  void launchMap(travelMap) async {
    ;
    if (await canLaunch(travelMap)) {
      print("Can launch");
      void initState() {
        super.initState();

        canLaunch(travelMap);
      }

      await launch(travelMap);
    } else {
      print("Could not launch");
      throw 'Could not launch Maps';
    }
  }

  void makeDialog() {
    showDialog(
        context: context,
        builder: (_) => new SimpleDialog(
              contentPadding: EdgeInsets.only(left: 30.0, top: 30.0),
              children: <Widget>[
                new Text(
                  "Address: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                new ButtonBar(
                  children: <Widget>[
                    new IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                )
              ],
            ));
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
}

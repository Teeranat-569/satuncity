// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:satuncity/loading/loading_screen.dart';
import 'package:satuncity/screen/admin/admin.dart';

class AddTravel extends StatefulWidget {
  const AddTravel({Key key}) : super(key: key);

  @override
  _AddTravelState createState() => _AddTravelState();
}

class _AddTravelState extends State<AddTravel> {
  String dropdownvalue = 'ทะเล';
  dynamic travelName, pathPIC, positive, travel_map;
  dynamic img, img_mountain, img_waterfall, img_region, img_r;
  TextEditingController travelNameController = TextEditingController();
  TextEditingController positiveController = TextEditingController();
  TextEditingController travelMapController = TextEditingController();

  var _image;

  // List of items in our dropdown menu
  var items = ['ทะเล', 'ภูเขา', 'น้ำตก', 'ศาสนสถาน'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('สถานที่ท่องเที่ยว'),
          actions: [
            TextButton(
              onPressed: () async {
                LoadingScreen().show(
                  context: context,
                  text: 'Please wait a moment',
                );

                // await for 2 seconds to Mock Loading Data
                await Future.delayed(const Duration(seconds: 3));
              

                // Call LoadingScreen().hide() to HIDE  Loading Dialog
                Random random = Random();
                int i = random.nextInt(100000);
                await firebase_core.Firebase.initializeApp();
                final firebase_storage.FirebaseStorage storage =
                    firebase_storage.FirebaseStorage.instance;
                File file = File(pathPIC);
                if (dropdownvalue == 'ทะเล') {
                  try {
                    await storage.ref('travel/travel_sea_$i').putFile(file);
                    dynamic url = await storage
                        .ref('travel/travel_sea_$i')
                        .getDownloadURL();
                    setState(() {
                      img = url;
                    });
                    print('7777777777777777777777777777$img');
                    print(
                        '77777777777777777222222eeeeeeeeee222222277777777777$url');
                  } on firebase_core.FirebaseException catch (e) {
                    // ignore: avoid_print
                    print(e);
                  }
                  addTravel_sea();
                  MaterialPageRoute materialPageRoute = MaterialPageRoute(
                      builder: (BuildContext context) => Admin());
                  Navigator.of(context).pushAndRemoveUntil(
                      materialPageRoute, (Route<dynamic> route) => false);
                }

                if (dropdownvalue == 'ภูเขา') {
                  Random random = Random();
                  int i = random.nextInt(100000);
                  await firebase_core.Firebase.initializeApp();
                  final firebase_storage.FirebaseStorage storage_mountain =
                      firebase_storage.FirebaseStorage.instance;
                  File file = File(pathPIC);
                  try {
                    await storage_mountain
                        .ref('travel/travel_mountain_$i')
                        .putFile(file);
                    dynamic url_mountain = await storage_mountain
                        .ref('travel/travel_mountain_$i')
                        .getDownloadURL();
                    setState(() {
                      img_mountain = url_mountain;
                    });
                    print('7777777777777777777777777777$img_mountain');
                    print(
                        '77777777777777777222222222222277777777777$url_mountain');
                  } on firebase_core.FirebaseException catch (e) {
                    // ignore: avoid_print
                    print(e);
                  }
                  addTravel_mountain();
                  MaterialPageRoute materialPageRoute = MaterialPageRoute(
                      builder: (BuildContext context) => Admin());
                  Navigator.of(context).pushAndRemoveUntil(
                      materialPageRoute, (Route<dynamic> route) => false);
                  print(
                      '7777777777777777777777eeeeeeeeeeeeeeeeee777777------travel_mountain$i.jpg');
                }

                if (dropdownvalue == 'น้ำตก') {
                  try {
                    await storage
                        .ref('travel/travel_waterfall_$i')
                        .putFile(file);
                    dynamic url_waterfall = await storage
                        .ref('travel/travel_waterfall_$i')
                        .getDownloadURL();
                    setState(() {
                      img_waterfall = url_waterfall;
                    });
                    print('7777777777777777777777777777$img_waterfall');
                    print(
                        '77777777777777777222222222222277777777777$url_waterfall');
                  } on firebase_core.FirebaseException catch (e) {
                    // ignore: avoid_print
                    print(e);
                  }
                  addTravel_waterfall();
                  MaterialPageRoute materialPageRoute = MaterialPageRoute(
                      builder: (BuildContext context) => Admin());
                  Navigator.of(context).pushAndRemoveUntil(
                      materialPageRoute, (Route<dynamic> route) => false);
                  print(
                      '7777777777777777777777eeeeeeeeeeeeeeeeee777777------travel_waterfall$i.jpg');
                }
                if (dropdownvalue == 'ศาสนสถาน') {
                  try {
                    await storage.ref('travel/travel_region_$i').putFile(file);
                    dynamic url_region = await storage
                        .ref('travel/travel_region_$i')
                        .getDownloadURL();
                    setState(() {
                      img_region = url_region;
                    });
                    print('7777777777777777777777777777$img_region');
                    print(
                        '77777777777777777222222222222277777777777$url_region');
                  } on firebase_core.FirebaseException catch (e) {
                    // ignore: avoid_print
                    print(e);
                  }
                  addTravel_region();
                  print(
                      '7777777777777777777777eeeeeeeeeeeeeeeeee777777------travel_region$i.jpg');
                  MaterialPageRoute materialPageRoute = MaterialPageRoute(
                      builder: (BuildContext context) => Admin());
                  Navigator.of(context).pushAndRemoveUntil(
                      materialPageRoute, (Route<dynamic> route) => false);
                }

                uploadData(travelNameController.text);
                LoadingScreen().hide();
              },
              child: Text(
                'เพิ่มสถานที่',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('เลือกหมวดหมู่สถานที่ท่องเที่ยว : '),
                    SizedBox(
                      width: 10,
                    ),
                    DropdownButton(
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (dynamic newValue) async {
                        setState(() {
                          dropdownvalue = newValue;
                        });
                      },
                    ),
                  ],
                ),
                showImage(),
                IconButton(
                    onPressed: () {
                      getImage();
                    },
                    icon: const Icon(
                      Icons.file_upload,
                      size: 40,
                    )),
                const SizedBox(
                  height: 15,
                ),
                travelNameForm(),
                const SizedBox(
                  height: 10,
                ),
                positiveForm(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text('พิกัด : '),
                    Container(
                      child: travelMapForm(),
                      width: 200,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> uploadData(String name) async {
    List<String> splitList = name.split(' ');
    List<String> indexList = [];
    for (var i = 0; i < splitList.length; i++) {
      for (var j = 0; j < splitList[i].length; j++) {
        indexList.add(splitList[i].substring(0, j).toLowerCase());
      }
    }
    final database = FirebaseFirestore.instance;
    if (dropdownvalue == 'ทะเล') {
      img_r = img;
    }
    if (dropdownvalue == 'ภูเขา') {
      img_r = img_mountain;
    }
    if (dropdownvalue == 'น้ำตก') {
      img_r = img_waterfall;
    }
    if (dropdownvalue == 'ศาสนสถาน') {
      img_r = img_region;
    }
    database
        .collection('travel_name')
        .add({'name': name, 'searchIndex': indexList, 'pic': img_r});
  }

  Widget cate(var text, Widget routeName, String pathIMG) {
    //ทะเล
    return InkWell(
      child: Container(
          height: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/sea.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(99, 0, 0, 0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => routeName);
        Navigator.push(context, route);
      },
    );
  }

  Widget travelNameForm() {
    return TextField(
      onChanged: (value) => travelName = value.trim(),
      controller: travelNameController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'ชื่อสถานที่',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: Colors.grey.shade400,
                  style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }

  Widget positiveForm() {
    return TextField(
      onChanged: (value) => positive = value.trim(),
      controller: positiveController,
      maxLines: 3,
      decoration: InputDecoration(
          hintText: 'ลักษณะเด่น',
          hintTextDirection: TextDirection.ltr,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: Colors.grey.shade400,
                  style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }

  Widget travelMapForm() {
    return TextField(
      onChanged: (value) => travel_map = value.trim(),
      controller: travelMapController,
      decoration: InputDecoration(
          hintText: 'ลิ้งก์จาก Google Map',
          hintTextDirection: TextDirection.ltr,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: Colors.grey.shade400,
                  style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }

  Widget showImage() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        width: 300.0,
        height: 200.0,
        child: _image == null
            ? Center(child: Text('ไม่ได้อัปโหลดรูปภาพ'))
            : ClipRect(
                child: InteractiveViewer(
                    maxScale: 20, child: Image.file(_image))));
  }

  Future getImage() async {
    final pickedFile =
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

  // Widget button() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Container(
  //       width: 200,
  //       child: RaisedButton(
  //         child: const Text("เพิ่มสถานที่",
  //             style: TextStyle(
  //               fontSize: 20,
  //               color: Colors.white,
  //               fontWeight: FontWeight.bold,
  //             )),
  //         onPressed: () async {
  //           Random random = Random();
  //           int i = random.nextInt(100000);
  //           await firebase_core.Firebase.initializeApp();
  //           final firebase_storage.FirebaseStorage storage =
  //               firebase_storage.FirebaseStorage.instance;
  //           File file = File(pathPIC);
  //           if (dropdownvalue == 'ทะเล') {
  //             try {
  //               await storage.ref('travel/travel_sea_$i').putFile(file);
  //               dynamic url =
  //                   await storage.ref('travel/travel_sea_$i').getDownloadURL();
  //               setState(() {
  //                 img = url;
  //               });

  //               print('7777777777777777777777777777$img');
  //               print(
  //                   '77777777777777777222222eeeeeeeeee222222277777777777$url');
  //             } on firebase_core.FirebaseException catch (e) {
  //               // ignore: avoid_print
  //               print(e);
  //             }
  //             addTravel_sea();
  //             MaterialPageRoute materialPageRoute =
  //                 MaterialPageRoute(builder: (BuildContext context) => Admin());
  //             Navigator.of(context).pushAndRemoveUntil(
  //                 materialPageRoute, (Route<dynamic> route) => false);
  //           }

  //           if (dropdownvalue == 'ภูเขา') {
  //             Random random = Random();
  //             int i = random.nextInt(100000);
  //             await firebase_core.Firebase.initializeApp();
  //             final firebase_storage.FirebaseStorage storage_mountain =
  //                 firebase_storage.FirebaseStorage.instance;
  //             File file = File(pathPIC);
  //             try {
  //               await storage_mountain
  //                   .ref('travel/travel_mountain_$i')
  //                   .putFile(file);
  //               dynamic url_mountain = await storage_mountain
  //                   .ref('travel/travel_mountain_$i')
  //                   .getDownloadURL();
  //               setState(() {
  //                 img_mountain = url_mountain;
  //               });

  //               print('7777777777777777777777777777$img_mountain');
  //               print('77777777777777777222222222222277777777777$url_mountain');
  //             } on firebase_core.FirebaseException catch (e) {
  //               // ignore: avoid_print
  //               print(e);
  //             }
  //             addTravel_mountain();
  //             MaterialPageRoute materialPageRoute =
  //                 MaterialPageRoute(builder: (BuildContext context) => Admin());
  //             Navigator.of(context).pushAndRemoveUntil(
  //                 materialPageRoute, (Route<dynamic> route) => false);
  //             print(
  //                 '7777777777777777777777eeeeeeeeeeeeeeeeee777777------travel_mountain$i.jpg');
  //           }

  //           if (dropdownvalue == 'น้ำตก') {
  //             try {
  //               await storage.ref('travel/travel_waterfall_$i').putFile(file);
  //               dynamic url_waterfall = await storage
  //                   .ref('travel/travel_waterfall_$i')
  //                   .getDownloadURL();
  //               setState(() {
  //                 img_waterfall = url_waterfall;
  //               });

  //               // print('7777777777777777777777777777travel$i');
  //               print('7777777777777777777777777777$img_waterfall');
  //               print(
  //                   '77777777777777777222222222222277777777777$url_waterfall');
  //             } on firebase_core.FirebaseException catch (e) {
  //               // ignore: avoid_print
  //               print(e);
  //             }
  //             addTravel_waterfall();
  //             MaterialPageRoute materialPageRoute =
  //                 MaterialPageRoute(builder: (BuildContext context) => Admin());
  //             Navigator.of(context).pushAndRemoveUntil(
  //                 materialPageRoute, (Route<dynamic> route) => false);
  //             print(
  //                 '7777777777777777777777eeeeeeeeeeeeeeeeee777777------travel_waterfall$i.jpg');
  //           }
  //           if (dropdownvalue == 'ศาสนสถาน') {
  //             try {
  //               await storage.ref('travel/travel_region_$i').putFile(file);
  //               dynamic url_region = await storage
  //                   .ref('travel/travel_region_$i')
  //                   .getDownloadURL();
  //               setState(() {
  //                 img_region = url_region;
  //               });

  //               print('7777777777777777777777777777$img_region');
  //               print('77777777777777777222222222222277777777777$url_region');
  //             } on firebase_core.FirebaseException catch (e) {
  //               // ignore: avoid_print
  //               print(e);
  //             }
  //             addTravel_region();
  //             print(
  //                 '7777777777777777777777eeeeeeeeeeeeeeeeee777777------travel_region$i.jpg');
  //             MaterialPageRoute materialPageRoute =
  //                 MaterialPageRoute(builder: (BuildContext context) => Admin());
  //             Navigator.of(context).pushAndRemoveUntil(
  //                 materialPageRoute, (Route<dynamic> route) => false);
  //           }

  //           uploadData(travelNameController.text);
  //         },
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(14.0),
  //             side: const BorderSide(color: Colors.cyan)),
  //         color: Colors.cyan,
  //         textColor: Colors.white,
  //         padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
  //         splashColor: Colors.grey,
  //       ),
  //     ),
  //   );
  // }

  CollectionReference travel_sea =
      FirebaseFirestore.instance.collection('travel');
  Future<void> addTravel_sea() {
    // ignore: unnecessary_statements
    if (img == null || img == '') img == "ไม่มี";
    return travel_sea.add({
      'travelName': travelName,
      'positive': positive,
      'pic': img,
      'travel_map': travel_map,
      'travelCate': dropdownvalue,
    }).then((value) {
      // ignore: avoid_print
      // print('7777777777777777777----------bbbbb$img');
      print(
          '7777777777777777777------------------------555555555-------------777777777' +
              img);
      print(
          "3636363636363636363636363636363636363636363636363636363636363636User Added" +
              travelName);
      print('xxxxxxxxxxxxxxxxxxxxxxxxxxx' + dropdownvalue);
      Fluttertoast.showToast(
        msg: "เพิ่มสถานที่ท่องเที่ยวสำเร็จ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.purple[100],
        textColor: Colors.black,
      );

      // ignore: avoid_print, invalid_return_type_for_catch_error
    }).catchError((error) => print("Failed to add user: $error"));
  }

  CollectionReference travel_mountain =
      FirebaseFirestore.instance.collection('travel_mountain');
  Future<void> addTravel_mountain() {
    // ignore: unnecessary_statements
    if (img == null || img == '') img == "ไม่มี";
    return travel_mountain.add({
      'travelName': travelName,
      'positive': positive,
      'pic': img_mountain,
      'travel_map': travel_map,
      'travelCate': dropdownvalue,
    }).then((value) {
      // ignore: avoid_print
      // print('7777777777777777777----------bbbbb$img');
      print(
          '7777777777777777777------------------------555555555-------------777777777' +
              img);
      print(
          "3636363636363636363636363636363636363636363636363636363636363636User Added" +
              travelName);
      print('xxxxxxxxxxxxxxxxxxxxxxxxxxx' + dropdownvalue);
      Fluttertoast.showToast(
        msg: "เพิ่มสถานที่ท่องเที่ยวสำเร็จ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.purple[100],
        textColor: Colors.black,
      );

      // ignore: avoid_print, invalid_return_type_for_catch_error
    }).catchError((error) => print("Failed to add user: $error"));
  }

  CollectionReference travel_waterfall =
      FirebaseFirestore.instance.collection('travel_waterfall');
  Future<void> addTravel_waterfall() {
    // ignore: unnecessary_statements
    if (img == null || img == '') img == "ไม่มี";
    return travel_waterfall.add({
      'travelName': travelName,
      'positive': positive,
      'pic': img_waterfall,
      'travel_map': travel_map,
      'travelCate': dropdownvalue,
    }).then((value) {
      // ignore: avoid_print
      // print('7777777777777777777----------bbbbb$img');
      print(
          '7777777777777777777------------------------555555555-------------777777777' +
              img);
      print(
          "3636363636363636363636363636363636363636363636363636363636363636User Added" +
              travelName);
      print('xxxxxxxxxxxxxxxxxxxxxxxxxxx' + dropdownvalue);
      Fluttertoast.showToast(
        msg: "เพิ่มสถานที่ท่องเที่ยวสำเร็จ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.purple[100],
        textColor: Colors.black,
      );

      // ignore: avoid_print, invalid_return_type_for_catch_error
    }).catchError((error) => print("Failed to add user: $error"));
  }

  CollectionReference travel_region =
      FirebaseFirestore.instance.collection('travel_region');
  Future<void> addTravel_region() {
    // ignore: unnecessary_statements
    if (img == null || img == '') img == "ไม่มี";
    return travel_region.add({
      'travelName': travelName,
      'positive': positive,
      'pic': img_region,
      'travel_map': travel_map,
      'travelCate': dropdownvalue,
    }).then((value) {
      // ignore: avoid_print
      print(
          '7777777777777777777------------------------555555555-------------777777777' +
              img);
      print(
          "3636363636363636363636363636363636363636363636363636363636363636User Added" +
              travelName);
      print('xxxxxxxxxxxxxxxxxxxxxxxxxxx' + dropdownvalue);
      Fluttertoast.showToast(
        msg: "เพิ่มสถานที่ท่องเที่ยวสำเร็จ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.purple[100],
        textColor: Colors.black,
      );

      // ignore: avoid_print, invalid_return_type_for_catch_error
    }).catchError((error) => print("Failed to add user: $error"));
  }
}

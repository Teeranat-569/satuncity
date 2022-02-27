// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:satuncity/screen/admin/admin.dart';

class AddTravel extends StatefulWidget {
  const AddTravel({Key key}) : super(key: key);

  @override
  _AddTravelState createState() => _AddTravelState();
}

class _AddTravelState extends State<AddTravel> {
  String dropdownvalue = 'ทะเล';
  String travelName, pathPIC, positive, travel_map;
  dynamic img;
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
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String newValue) async {
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
                button()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cate(var text, Widget routeName, String pathIMG) {
    //ทะเล
    return InkWell(
      child: Container(
          height: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/hinngam.jpg'),
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
                  width: 2, color: Colors.grey[400], style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }

  Widget positiveForm() {
    return TextField(
      onChanged: (value) => positive = value.trim(),
      controller: positiveController,
      maxLines: 3,
      // keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'ลักษณะเด่น',
          hintTextDirection: TextDirection.ltr,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Colors.grey[400], style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }

  Widget travelMapForm() {
    return TextField(
      onChanged: (value) => travel_map = value.trim(),
      controller: travelMapController,
      // maxLines: 3,
      // keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'ลิ้งก์จาก Google Map',
          hintTextDirection: TextDirection.ltr,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Colors.grey[400], style: BorderStyle.solid)),
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

  Widget button() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        child: RaisedButton(
          child: const Text("เพิ่มสถานที่",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          onPressed: () async {
            Random random = Random();
            int i = random.nextInt(100000);
            await firebase_core.Firebase.initializeApp();
            final firebase_storage.FirebaseStorage storage =
                firebase_storage.FirebaseStorage.instance;
            File file = File(pathPIC);
            // print('222222222222222222222222222222 ${pathPIC},');
            try {
              await storage.ref('travel/travel_$i').putFile(file);
              dynamic url =
                  await storage.ref('travel/travel_$i').getDownloadURL();
              img = url;
              // print('7777777777777777777777777777travel$i');
              print('7777777777777777777777777777$img');
              print('77777777777777777222222222222277777777777$url');
            } on firebase_core.FirebaseException catch (e) {
              // ignore: avoid_print
              print(e);
            }
            // print(
            //     '7777777777777777777-------------------------------------777777777 ');
            addTravel();

            print(
                '7777777777777777777777eeeeeeeeeeeeeeeeee777777travel_$i.jpg');
            // print('7777777777777777777777777777$img');
            // addTravel();
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
              side: const BorderSide(color: Colors.cyan)),
          color: Colors.cyan,
          textColor: Colors.white,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          splashColor: Colors.grey,
        ),
      ),
    );
  }

  CollectionReference travel = FirebaseFirestore.instance.collection('travel');
  Future<void> addTravel() {
    // ignore: unnecessary_statements
    if (img == null || img == '') img == "ไม่มี";
    return travel.add({
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
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Admin());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
      // ignore: avoid_print, invalid_return_type_for_catch_error
    }).catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> uploadFile(String filePath, String fileName) async {
    await firebase_core.Firebase.initializeApp();
    final firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    File file = File(filePath);
    try {
      await storage.ref('company/$fileName').putFile(file);
      dynamic url = await storage.ref('company/$fileName').getDownloadURL();
      // setState(() {
      img = url;
      // downloadURLExample(fileName);
      print('7777777777777777777777777777$fileName');
      print(
          '7777777777777777777-------------------------------------777777777$img');
      print(
          '7777777777777777777------------------------555555555-------------777777777$url');
      // });
    } on firebase_core.FirebaseException catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}

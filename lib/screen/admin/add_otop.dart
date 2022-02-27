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

class AddOtop extends StatefulWidget {
  const AddOtop({Key key}) : super(key: key);

  @override
  _AddOtopState createState() => _AddOtopState();
}

class _AddOtopState extends State<AddOtop> {
  
  String otop_name, pathPIC, otop_data, otop_map;
  dynamic img;
  TextEditingController otopNameController = TextEditingController();
  TextEditingController otopDataController = TextEditingController();
  TextEditingController otopMapController = TextEditingController();
  var _image;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('สินค้า OTOP'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
                const SizedBox(
                  height: 15,
                ),
                otopNameForm(),
                const SizedBox(
                  height: 10,
                ),
                otopDataForm(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text('พิกัด : '),
                    Container(
                      child: otopMapForm(),
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

  Widget otopNameForm() {
    return TextField(
      onChanged: (value) => otop_name = value.trim(),
      controller: otopNameController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'ชื่อสินค้า',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Colors.grey[400], style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }

  Widget otopDataForm() {
    return TextField(
      onChanged: (value) => otop_data = value.trim(),
      controller: otopDataController,
      maxLines: 3,
      // keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'ข้อมูลสินค้า',
          hintTextDirection: TextDirection.ltr,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Colors.grey[400], style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }

  Widget otopMapForm() {
    return TextField(
      onChanged: (value) => otop_map = value.trim(),
      controller: otopMapController,
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
          child: const Text("เพิ่มสินค้า",
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

  CollectionReference travel = FirebaseFirestore.instance.collection('otop');
  Future<void> addTravel() {
     // ignore: unnecessary_statements
     if (img == null || img == '') img == "ไม่มี";
    return travel.add({
      'otop_name': otop_name,
      'otop-data': otop_data,
      'otop_pic': img,
      'otop_map': otop_map,
      
    }).then((value) {
      // ignore: avoid_print
      // print('7777777777777777777----------bbbbb$img');
      print(
          '7777777777777777777------------------------555555555-------------777777777' +
              img);
      print(
          "3636363636363636363636363636363636363636363636363636363636363636User Added" +
              otop_name);
      // print('xxxxxxxxxxxxxxxxxxxxxxxxxxx' + dropdownvalue);
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

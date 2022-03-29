// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:satuncity/loading/loading_screen.dart';
import 'package:satuncity/screen/admin/admin.dart';
import 'package:path/path.dart' as Path;

class AddFestival extends StatefulWidget {
  const AddFestival({Key key}) : super(key: key);

  @override
  _AddFestivalState createState() => _AddFestivalState();
}

class _AddFestivalState extends State<AddFestival> {
  dynamic festival_name, pathPIC, festival_data;
  dynamic img;
  double val = 0;
  TextEditingController festivalNameController = TextEditingController();
  TextEditingController festivalDataController = TextEditingController();
  var _image2;
  bool uploading = false;
  final picker = ImagePicker();
  firebase_storage.Reference ref;
  CollectionReference imgRef;
  List<File> _imagef = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('งานประจำปี'),
        actions: [
          TextButton(
              onPressed: () async {
                LoadingScreen().show(
                  context: context,
                  text: 'Please wait a moment',
                );

                // await for 2 seconds to Mock Loading Data
                await Future.delayed(const Duration(seconds: 3));
                uploadFile().whenComplete(() {
                  MaterialPageRoute materialPageRoute = MaterialPageRoute(
                      builder: (BuildContext context) => Admin());
                  Navigator.of(context).pushAndRemoveUntil(
                      materialPageRoute, (Route<dynamic> route) => false);
                });
                await firebase_core.Firebase.initializeApp();
                LoadingScreen().hide();
              },
              child: Text(
                'เพิ่มงานประจำปี',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _imagef.length + 1,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          return index == 0
                              ? Container(
                                  color: Colors.grey.shade300,
                                  child: Center(
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.add_photo_alternate,
                                          size: 40,
                                        ),
                                        onPressed: () =>
                                            !uploading ? chooseImage() : null),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(_imagef[index - 1]),
                                          fit: BoxFit.cover)),
                                );
                        }),
                  ),
                ],
              ),
              uploading
                  ? Center(
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: const Text(
                            'uploading...',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CircularProgressIndicator(
                          value: val,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.green),
                        )
                      ],
                    ))
                  : Container(),
              const SizedBox(
                height: 15,
              ),
              festivalNameForm(),
              const SizedBox(
                height: 10,
              ),
              festivalDataForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget festivalNameForm() {
    return TextField(
      onChanged: (value) => festival_name = value.trim(),
      controller: festivalNameController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'ชื่อร้านอาหาร',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Colors.grey, style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(Icons.drive_file_rename_outline)),
    );
  }

  Widget festivalDataForm() {
    return TextField(
      onChanged: (value) => festival_data = value.trim(),
      controller: festivalDataController,
      maxLines: 3,
      // keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'ข้อมูลร้านอาหาร',
          hintTextDirection: TextDirection.ltr,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Colors.grey, style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(Icons.description)),
    );
  }

  Widget showImage() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        width: 300.0,
        height: 200.0,
        child: _image2 == null
            ? Center(child: Text('ไม่ได้อัปโหลดรูปภาพ'))
            : ClipRect(
                child: InteractiveViewer(
                    maxScale: 20, child: Image.file(_image2))));
  }

  Future getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image2 = File(pickedFile.path);
        pathPIC = pickedFile.path;
        print('ffffffffffffffffffffffffffffs' + pathPIC);
      } else {
        print('No image selected.');
      }
    });
  }

  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imagef.add(File(pickedFile.path));
    });
    if (pickedFile.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imagef.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    int i = 1;
    List<String> indexList = [];
    for (var img in _imagef) {
      val = i / _imagef.length;

      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('festival/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          indexList.add(value);
          i++;
        });
      });
    }
    final database = FirebaseFirestore.instance;
    database.collection('festival').add({
      'fes_pic': indexList, 'fes_name': festival_name,
      'fes_data': festival_data,
      // 'res_pic': img,
    });
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => Admin());
    Navigator.of(context)
        .pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('festival');
  }
}

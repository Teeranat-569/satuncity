// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:satuncity/screen/admin/admin.dart';import 'package:path/path.dart' as Path;

class Addrestaurant extends StatefulWidget {
  const Addrestaurant({Key key}) : super(key: key);

  @override
  _AddrestaurantState createState() => _AddrestaurantState();
}

class _AddrestaurantState extends State<Addrestaurant> {
  dynamic restaurant_name,
      pathPIC,
      restaurant_data,
      restaurant_map,
      restaurantAddress;
  dynamic img;
  double val = 0;
  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController restaurantDataController = TextEditingController();
  TextEditingController restaurantMapController = TextEditingController();
  TextEditingController restaurantAddressController = TextEditingController();
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
        title: Text('ร้านอาหาร'),
        actions: [
          TextButton(
              onPressed: () async {
               
                uploadFile().whenComplete(() {
                  MaterialPageRoute materialPageRoute = MaterialPageRoute(
                      builder: (BuildContext context) => Admin());
                  Navigator.of(context).pushAndRemoveUntil(
                      materialPageRoute, (Route<dynamic> route) => false);
                });
                await firebase_core.Firebase.initializeApp();
              },
              child: Text(
                'เพิ่มร้านอาหาร',
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
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.green),
                        )
                      ],
                    ))
                  : Container(),
            
              const SizedBox(
                height: 15,
              ),
              restaurantNameForm(),
              const SizedBox(
                height: 10,
              ),
              restaurantDataForm(),
              const SizedBox(
                height: 10,
              ),
              restaurantAddressForm(),
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
            ],
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

  Widget restaurantNameForm() {
    return TextField(
      onChanged: (value) => restaurant_name = value.trim(),
      controller: restaurantNameController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'ชื่อร้านอาหาร',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Colors.grey.shade400, style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(Icons.drive_file_rename_outline)),
    );
  }

  Widget restaurantDataForm() {
    return TextField(
      onChanged: (value) => restaurant_data = value.trim(),
      controller: restaurantDataController,
      maxLines: 3,
      decoration: InputDecoration(
          hintText: 'ข้อมูลร้านอาหาร',
          hintTextDirection: TextDirection.ltr,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Colors.grey.shade400, style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(Icons.description)),
    );
  }

  Widget restaurantAddressForm() {
    return TextField(
      onChanged: (value) => restaurantAddress = value.trim(),
      controller: restaurantAddressController,
      maxLines: 3,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'ที่อยู่ร้านอาหาร',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Colors.grey.shade400, style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),prefixIcon: Icon(Icons.room)),
    );
  }

  Widget otopMapForm() {
    return TextField(
      onChanged: (value) => restaurant_map = value.trim(),
      controller: restaurantMapController,
      decoration: InputDecoration(
          hintText: 'ลิ้งก์จาก Google Map',
          hintTextDirection: TextDirection.ltr,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Colors.grey.shade400, style: BorderStyle.solid)),
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
        child: _image2 == null
            ? Center(child: Text('ไม่ได้อัปโหลดรูปภาพ'))
            : ClipRect(
                child: InteractiveViewer(
                    maxScale: 20, child: Image.file(_image2))));
  }

  Future getImage() async {
    final pickedFile =
        // ignore: deprecated_member_use
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
    Random o = Random();
    int oR = o.nextInt(10000);
    for (var img in _imagef) {
      
        val = i / _imagef.length;
    

      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('restaurant/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          // imgRef.add({'url': value});
          indexList.add(value);
          i++;
        });
      });
    }
    final database = FirebaseFirestore.instance;
    database.collection('restaurant').add({'res_pic': indexList, 'res_name': restaurant_name,
      'res-data': restaurant_data,
      // 'res_pic': img,
      'res_map': restaurant_map,
      'res_address': restaurantAddress,});
        MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Admin());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('restaurant');
  }
}

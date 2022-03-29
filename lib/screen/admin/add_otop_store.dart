// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:satuncity/loading/loading_screen.dart';
import 'package:satuncity/screen/admin/admin.dart';
import 'package:path/path.dart' as Path;

class AddOtopStore extends StatefulWidget {
  const AddOtopStore({Key key}) : super(key: key);

  @override
  _AddOtopStoreState createState() => _AddOtopStoreState();
}

class _AddOtopStoreState extends State<AddOtopStore> {
  String dropdownvalue;
  var items;
  String dropdownValue = 'One';

  dynamic restaurant_name,
      pathPIC,
      restaurant_data,
      restaurant_map,
      restaurantAddress,
      facebook,
      line,
      website,
      phone;
  dynamic img;
  double val = 0;
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeDataController = TextEditingController();
  TextEditingController storeMapController = TextEditingController();
  TextEditingController storeAddressController = TextEditingController();
  TextEditingController facebookController = TextEditingController();

  TextEditingController lineController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController websiteAddressController = TextEditingController();

  var _image2;
  bool uploading = false;
  final picker = ImagePicker();
  firebase_storage.Reference ref;
  CollectionReference imgRef;
  List<File> _imagef = [];

  // @override
  // void initState() {
  //   super.initState();
  //   items = [];
  //   FirebaseFirestore.instance
  //       .collection('otop')
  //       .where('otop_name')
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       print(doc["otop_name"]);
  //       restaurant_name = doc["otop_name"];
  //     });
  //   });
  //   print('kkkkkkkkkkkkkkkkkkkkkk $restaurant_name');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ร้านขายสินค้า OTOP'),
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
                'เพิ่มร้าน',
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
              StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection('otop').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );

                    return Container(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              // flex: 2,
                              child: Container(
                            padding:
                                EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 10.0),
                            child: Text(
                              "เลือกสินค้า OTOP",
                            ),
                          )),
                          new Expanded(
                            child: DropdownButton(
                              value: dropdownvalue,
                              // isDense: true,
                              hint: Text('สินค้า'),
                              onChanged: (valueSelectedByUser) {
                                setState(() {
                                  dropdownvalue = valueSelectedByUser;
                                  print('dddddddddddd $valueSelectedByUser');
                                });
                              },
                              items: snapshot.data.docs
                                  .map((DocumentSnapshot document) {
                                return DropdownMenuItem<String>(
                                  value: document['otop_name'],
                                  child: Text(document['otop_name']),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              storeNameForm(),
              const SizedBox(
                height: 10,
              ),
              storeAddressForm(),
              const SizedBox(
                height: 10,
              ),
              storeDataForm(),
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
              const SizedBox(
                height: 10,
              ),
              storefacebookForm(),
              storelineForm(),
              storewebForm()
            ],
          ),
        ),
      ),
    );
  }

  Widget storeNameForm() {
    return TextField(
      onChanged: (value) => restaurant_name = value.trim(),
      controller: storeNameController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'ชื่อร้าน',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: Colors.grey.shade400,
                  style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(Icons.drive_file_rename_outline)),
    );
  }

  Widget storeDataForm() {
    return TextField(
      onChanged: (value) => restaurant_data = value.trim(),
      controller: storeDataController,
      // maxLines: 3,
      decoration: InputDecoration(
          hintText: 'เบอร์โทร',
          hintTextDirection: TextDirection.ltr,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: Colors.grey.shade400,
                  style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(Icons.phone)),
    );
  }

  Widget storeAddressForm() {
    return TextField(
      onChanged: (value) => restaurantAddress = value.trim(),
      controller: storeAddressController,
      maxLines: 3,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'ที่อยู่ร้านอาหาร',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: Colors.grey.shade400,
                  style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(Icons.room)),
    );
  }

  Widget otopMapForm() {
    return TextField(
      onChanged: (value) => restaurant_map = value.trim(),
      controller: storeMapController,
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

  Widget storefacebookForm() {
    return TextField(
      onChanged: (value) => facebook = value.trim(),
      controller: facebookController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Facebook',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: Colors.grey.shade400,
                  style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(Icons.facebook)),
    );
  }

  Widget storelineForm() {
    return TextField(
      onChanged: (value) => line = value.trim(),
      controller: lineController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Line',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: Colors.grey.shade400,
                  style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(Icons.alternate_email)),
    );
  }

  Widget storewebForm() {
    return TextField(
      onChanged: (value) => website = value.trim(),
      controller: websiteAddressController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Website',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: Colors.grey.shade400,
                  style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(Icons.web)),
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
          .child('otop/otop_store/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          // imgRef.add({'url': value});
          indexList.add(value);
          i++;
        });
      });
    }
    final database = FirebaseFirestore.instance;
    database.collection('otop_store').add({
      'store_pic': indexList,
      'store_name': restaurant_name,
      'store_phone': restaurant_data,
      'otop_name': dropdownvalue,
      'store_map': restaurant_map,
      'store_address': restaurantAddress,
      'store_Line': line,
      'store_facebook': facebook,
      'store_website': website,
    });
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => Admin());
    Navigator.of(context)
        .pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
  }

  // Future readData() {
  //   items = [];
  //   FirebaseFirestore.instance
  //       .collection('otop')
  //       .where('otop_name')
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       print(doc["otop_name"]);
  //       setState(() {
  //         items.add(doc["otop_name"].toString());
  //         print('dddddddddddddddddddddddd $items');
  //       });
  //     });
  //   });
  // }
}

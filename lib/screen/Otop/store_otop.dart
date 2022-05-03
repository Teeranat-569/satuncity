// ignore_for_file: non_constant_identifier_names, must_be_immutable, unused_element

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:satuncity/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreOtop extends StatefulWidget {
  dynamic storeName, otopName;
  StoreOtop({Key key, this.storeName, this.otopName}) : super(key: key);

  @override
  State<StoreOtop> createState() => _StoreOtopState();
}

class _StoreOtopState extends State<StoreOtop> {
  dynamic otopName,
      store_Line,
      store_address,
      store_facebook,
      store_name,
      store_website,
      store_index,
      store_email,
      store_map,
      store_phone;
  List url;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('otop_store').snapshots();
  CollectionReference users =
      FirebaseFirestore.instance.collection('otop_store');
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
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Text(widget.storeName),
            backgroundColor: Colors.indigo,
          ),
          body: Container(
            // แสดงข้อมูล //////////////////////////////////////////////////////////////////////

            child: ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                data["docid"] = document.id;
                otopName = data['otop_name'];
                store_Line = data['store_Line'];
                store_address = data['store_address'];
                store_facebook = data['store_facebook'];
                store_name = data['store_name'];
                store_phone = data['store_phone'];
                store_website = data['store_website'];
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
                      if (data['store_name'] == widget.storeName &&
                          data['otop_name'] == widget.otopName)
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                store_facebook == null || store_facebook == ''
                                    ? Text('')
                                    : IconButton(
                                        icon:
                                            Image.asset('images/facebook.png'),
                                        iconSize: 50,
                                        onPressed: () {
                                          launchMap(store_facebook);
                                        },
                                      ),
                                store_email == null || store_email == ''
                                    ? Text('')
                                    : IconButton(
                                        icon: Image.asset('images/email.png'),
                                        iconSize: 40,
                                        onPressed: () {
                                          launchMap(store_email);
                                        },
                                      ),
                                store_website == null || store_website == ''
                                    ? Text('')
                                    : IconButton(
                                        icon: Image.asset('images/website.jpg'),
                                        iconSize: 40,
                                        onPressed: () {
                                          launchMap(store_website);
                                        },
                                      ),
                                store_Line == null || store_Line == ''
                                    ? Text('')
                                    : IconButton(
                                        icon: Image.asset('images/line.png'),
                                        iconSize: 40,
                                        onPressed: () {
                                          launchMap(store_Line);
                                        },
                                      ),
                              ],
                            ),
                            store_name == null || store_name == ''
                                ? Text('ไม่มี')
                                : Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.indigo,
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                'ชื่อร้าน',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Container(
                                            width: 200,
                                            child: Text(store_name)),
                                      ),
                                    ],
                                  ),
                            store_address == null || store_address == ''
                                ? Text('ไม่มี')
                                : Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.indigo,
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                'ที่อยู่',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Container(
                                            width: 200,
                                            child: Text(store_address)),
                                      ),
                                    ],
                                  ),
                            store_phone == null || store_phone == ''
                                ? Text('ไม่มี')
                                : Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.indigo,
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                'เบอร์โทร',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(store_phone),
                                      ),
                                      IconButton(
                                        icon: Image.asset('images/Phone.png'),
                                        iconSize: 40,
                                        onPressed: () {
                                          _makePhoneCall(store_phone);
                                        },
                                      )
                                    ],
                                  ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.indigo,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          'แผนที่',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                store_map == null || store_map == ''
                                    ? Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text('ไม่มี'),
                                      )
                                    : Row(
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                launchMap(store_map);
                                              },
                                              child: Text('คลิกเพื่อดูแผนที่')),
                                          IconButton(
                                              icon: Icon(Icons.directions),
                                              onPressed: () {
                                                launchMap(store_map);
                                              }),
                                        ],
                                      ),
                              ],
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

  void launchMap(travelMap) async {
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

  Future<void> _makePhoneCall(String phoneNumber) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }
}

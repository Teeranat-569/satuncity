import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FoodData extends StatefulWidget {
  dynamic resName;
  FoodData({Key key, this.resName}) : super(key: key);
  @override
  _FoodDataState createState() => _FoodDataState();
}

class _FoodDataState extends State<FoodData> {
  dynamic resName, resData, resMap, resAdddress;
  String url;
  dynamic _image;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('restaurant').snapshots();
  CollectionReference users =
      FirebaseFirestore.instance.collection('restaurant');
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
              title: Text(widget.resName),
            ),
            // ignore: avoid_unnecessary_containers
            body: Container(
              // color: Colors.purple[50],
              child: ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  data["docid"] = document.id;
                  resName = data['res_name'];
                  resData = data['res-data'];
                  resMap = data['res_map'];
                  resAdddress = data['res_address'];
                  url = data['res_pic'].toString();

                  // ignore: avoid_print
                  print('4444444444444444444444444 ${data["docid"]}');
                  print('4444444444444444444444444 ${data["res_name"]}');
                  return Center(
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 10)),
                        if (data['res_name'] == widget.resName)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(url),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  // color: Colors.green,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.green,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'ลักษณะเด่น',
                                      // maxLines: 2,
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Text(resData),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  // color: Colors.green,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.green,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'ที่อยู่ร้านอาหาร',
                                      // maxLines: 2,
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Text(resAdddress),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  // color: Colors.green,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.green,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'พิกัด',
                                      // maxLines: 2,
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.directions),
                                  onPressed: () {
                                    launchMap(data['res_map']);
                                  }),
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("เกาะหินงาม"),
  //     ),
  //     body:
  //
  // Center(
  //       child: Column(
  //         children: [
  //           Padding(padding: EdgeInsets.only(top: 10)),
  //           Image.asset("images/hinn.jpg"),
  //           Padding(padding: EdgeInsets.all(10)),
  //           Text("     ลักษณะเด่น\n"
  //               "               เป็นเกาะเล็ก ๆ ที่ไม่มีหาดทรายแต่เป็นหาดที่มีก้อนหิน กลม รี"
  //               "วางเรียงรายอยู่เต็มเกาะ ยามน้ำทะเลซัดขึ้นมาก้อนหินเหล่านี้จะเปียกชุ่ม "
  //               "ส่องประกายมันวาวสะท้อนไปทั่วหาดหิน ยามน้ำลงแนวหาดหินจะปรากฏกว้างยิ่งขึ้นและจะตัดกับน้ำทะเลสีมรกต "
  //               "ซึ่งเป็นธรรมชาติที่สวยงามที่หาดูได้ยากในที่อื่น ๆ ในส่วนบริเวณรอบๆเกาะหินงาม"
  //               "ยังเป็นที่ดำน้ำดูปะการัง")
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
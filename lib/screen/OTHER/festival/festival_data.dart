import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:satuncity/drawer.dart';
import 'package:satuncity/screen/TRAVEL/post.dart';

// ignore: must_be_immutable
class FestivalData extends StatefulWidget {
  dynamic fesName, url;
  FestivalData({Key key, this.fesName,this.url}) : super(key: key);
  @override
  _FestivalDataState createState() => _FestivalDataState();
}

class _FestivalDataState extends State<FestivalData> {
  // ignore: non_constant_identifier_names
  dynamic fesName, fesData, fes_index, otopAdddress, fesMonth;
  dynamic url;
  List<dynamic> yy = [];

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('festival').snapshots();
  CollectionReference users = FirebaseFirestore.instance.collection('festival');
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
            title: Text(widget.fesName),
            backgroundColor: Colors.deepOrange.shade800,
                  actions: [
                Center(
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    color: Colors.deepOrange.shade900,
                      child: Text(
                        "รีวิว",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Yaldevi',
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Post(
                                travelName: widget.fesName,
                                picUrl: widget.url,
                              ),
                            ));
                        print('555555555555555555555555' + widget.fesName);
                        print('4444444444444444444' + widget.url);
                      }),
                ),
              ],
          ),
          // ignore: avoid_unnecessary_containers
          body: Container(
            child: ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                data["docid"] = document.id;
                fesName = data['fes_name'];
                fesData = data['fes_data'];
                fesMonth = data['fes_month'];
                yy = data['fes_pic'];
                // ignore: avoid_print
                print('4444444444444444444444444 ${data["docid"]}');
                print('4444444444444444444444444 ${data["fes_name"]}');
                return Center(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10)),
                      if (data['fes_name'] == widget.fesName)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                  height: 200.0, autoPlay: true),
                              items: [
                                for (var i = 0; i < yy.length; i++)
                                  {
                                    fes_index = data['fes_pic'][i].toString(),
                                    print(
                                        'dddddddddddddddddddddddddddddddddddddddd $fes_index'),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.deepOrange.shade800,
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'ช่วงจัดงานประจำปี',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, right: 10),
                              child: Text(fesMonth),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.deepOrange.shade800,
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
                              padding:
                                  const EdgeInsets.only(left: 25, right: 10),
                              child: Text(fesData),
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
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:satuncity/screen/OTHER/search_page.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'review_page.dart';

class Post extends StatefulWidget {
  dynamic travelName, picUrl;
  Post({Key key, this.travelName, this.picUrl}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final _formKey = GlobalKey<FormState>();
  String comments;
  double valued;
  var rating = 0.0;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ReviewPage()));
              },
              icon: Icon(Icons.arrow_back_ios)),
          actions: [
            TextButton(
                child:
                    Text('โพสต์รีวิว', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewPage(),
                      ));
                  addReview();
                }),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                              child: Row(
                                children: [
                                  Icon(Icons.search),
                                  if (widget.travelName == null ||
                                      widget.travelName == '')
                                    Text("เลือกสถานที่ท่องเที่ยว..",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ))
                                  else
                                    Text(widget.travelName)
                                ],
                              ),
                              style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.all(15)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: Colors.black)))),
                              onPressed: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Search(),
                                  ))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: TextFormField(
                            controller: textEditingController,
                            maxLines: 3,
                            decoration: InputDecoration(
                                hintText: "แสดงความคิดเห็น",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                hintTextDirection: TextDirection.ltr,
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.grey[400],
                                        style: BorderStyle.solid)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none)),
                            onSaved: (value) {
                              comments = value;
                            }),
                      ),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // MyStyle().sizedBox20(),
                  // Text('โปรดให้คะแนนการซ่อมบำรุงเพื่อประเมินความพึงพอใจ'),
                  // SizedBox(height: 50),
                  Center(
                      child: SmoothStarRating(
                    borderColor: Colors.orange.shade700,
                    color: Colors.pink[900],
                    rating: rating,
                    isReadOnly: false,
                    size: 35,
                    filledIconData: Icons.star,
                    halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border,
                    starCount: 5,
                    allowHalfRating: true,
                    spacing: 2.0,
                    onRated: (value) {
                      setState(() {
                        valued = value;
                        print("rating value -> $value");
                      });
                    },
                  )),
                  SizedBox(height: 50),

                  // nameForm(),
                  // ignore: deprecated_member_use
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  CollectionReference travel_sea =
      FirebaseFirestore.instance.collection('comment');
  Future<void> addReview() {
    // ignore: unnecessary_statements
    // if (img == null || img == '') img == "ไม่มี";
    return travel_sea.add({
      'travelName': widget.travelName,
      'comment': textEditingController.text,
      'pic': widget.picUrl,
      'rate': valued,
      // 'travelCate': dropdownvalue,
    }).then((value) {
      // ignore: avoid_print
      // print('7777777777777777777----------bbbbb$img');
      print(
          '7777777777777777777------------------------555555555-------------777777777' +
              widget.travelName);
      print(
          "3636363636363636363636363636363636363636363636363636363636363636User Added" +
              comments);
      print('xxxxxxxxxxxxxxxxxxxxxxxxxxx' + valued.toString());
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

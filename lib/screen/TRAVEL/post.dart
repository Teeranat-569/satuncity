import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:satuncity/model/rate_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

// ignore: must_be_immutable
class Post extends StatefulWidget {
  dynamic travelName, picUrl;
  Post({Key key, this.travelName, this.picUrl}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final _formKey = GlobalKey<FormState>();
  dynamic comments, comment, sumed, avgStr;
  dynamic valued;
  dynamic searchString, result;
  double rate, sumRate = 0, avg, rated;
  double sumDouble;
  var rating = 0.0;
  TextEditingController textEditingController = TextEditingController();
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('comment')
      .orderBy('timeago', descending: true)
      .snapshots();
  List rateList = [];
  List<RateModel> nn;
  Future<List<RateModel>> ww;
  @override
  void initState() {
    super.initState();
    readRate();
    // getData();
  }

  Future readRate() async {
    return FirebaseFirestore.instance
        .collection('comment')
        .orderBy('timeago', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        rated = doc["rate"];
        print("rrrrrrrrrrrrrrrrrrrrrrrrrrr");
        print(doc["rate"].toString());

        // print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
        // print(rate);
        setState(() {
          if (doc['travelName'] == widget.travelName) {
            rateList.add(rated);
            print('sssssssssssssssssssssssssssssssssssssss');
            print(rateList);
            print('ffffffffffffffffffffffff');
            print(rateList.length);
            sumRate = sumRate + rated;
            print('55555555555555555');
            print(sumRate);
          }
          print('5wwwwwwwwwwwwwwwwwwww');
          print(sumRate);
          print('-------------------f');
          print(rateList.length);
          avg = sumRate / rateList.length;
          print('************************');
          print(avg);
          sumed = avg.toStringAsFixed(1);
          sumDouble = double.parse('$sumed');
          print('111111111111111111');
          print(sumDouble);

          if (sumDouble <= 1.80) {
            avgStr = 'น้อยที่สุด';
          } else if (sumDouble <= 2.60) {
            avgStr = 'น้อย';
          } else if (sumDouble <= 3.40) {
            avgStr = 'ปานกลาง';
          } else if (sumDouble <= 4.20) {
            avgStr = 'มาก';
          } else {
            avgStr = 'มากที่สุด';
          }
        });
      });
    });
  }

  Widget _buildBody(BuildContext context) {
    Firebase.initializeApp(); // new
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('we got an error ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const SizedBox(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case ConnectionState.none:
            return const Text('no data');

          case ConnectionState.done:
            return const Text('we are done');

          default:
            return ListView(
                // reverse: true,
                children: snapshot.data.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              data["docid"] = document.id;
              result = data['travelName'];
              rate = data['rate'];
              comment = data['comment'];
              return Center(
                child: Column(
                  children: [
                    if (data['travelName'] == widget.travelName)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SmoothStarRating(
                                      borderColor: Colors.grey.shade400,
                                      color: Colors.pink.shade900,
                                      rating: rate,
                                      isReadOnly: false,
                                      size: 20,
                                      filledIconData: Icons.star,
                                      halfFilledIconData: Icons.star_half,
                                      defaultIconData: Icons.star_border,
                                      starCount: 5,
                                      allowHalfRating: true,
                                      spacing: 0,
                                      onRated: (value) {
                                        setState(() {
                                          valued = value;
                                          print("rating value -> $value");
                                        });
                                      },
                                    ),
                                    Text('($rate)')
                                  ],
                                ),
                                Text(comment)
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey.shade200,
                          )
                        ],
                      )
                  ],
                ),
              );
            }).toList());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          // backgroundColor: Colors.black,
          title: Text('รีวิว: ${widget.travelName}'),
          // leading: IconButton(
          //     onPressed: () {
          //       Navigator.pushReplacement(context,
          //           MaterialPageRoute(builder: (context) => ReviewPage()));
          //     },
          //     icon: Icon(Icons.arrow_back_ios)),
          actions: [
            TextButton(
                child:
                    Text('โพสต์รีวิว', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
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
                      // Padding(
                      //   padding:
                      //       const EdgeInsets.only(top: 10, left: 20, right: 20),
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     child: TextButton(
                      //         child: Row(
                      //           children: [
                      //             Icon(Icons.search),
                      //             if (widget.travelName == null ||
                      //                 widget.travelName == '')
                      //               Text("เลือกสถานที่ท่องเที่ยว..",
                      //                   style: TextStyle(
                      //                     fontSize: 14,
                      //                   ))
                      //             else
                      //               Text(widget.travelName)
                      //           ],
                      //         ),
                      //         style: ButtonStyle(
                      //             padding:
                      //                 MaterialStateProperty.all<EdgeInsets>(
                      //                     EdgeInsets.all(15)),
                      //             foregroundColor:
                      //                 MaterialStateProperty.all<Color>(
                      //                     Colors.black),
                      //             shape: MaterialStateProperty.all<
                      //                     RoundedRectangleBorder>(
                      //                 RoundedRectangleBorder(
                      //                     borderRadius:
                      //                         BorderRadius.circular(18.0),
                      //                     side: BorderSide(
                      //                         color: Colors.black)))),
                      //         onPressed: () => Navigator.pushReplacement(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (context) => Search(),
                      //             ))),
                      //   ),
                      // ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Text('คะแนนการรีวิว'),
                          SizedBox(height: 8),
                          Center(
                              child: SmoothStarRating(
                            borderColor: Colors.orange.shade700,
                            color: Colors.pink.shade900,
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
                          SizedBox(height: 15),
                        ],
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
                                fillColor: Colors.grey.shade200,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.grey.shade400,
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
              Icon(
                Icons.star,
                size: 50,
                color: Colors.amber,
              ),
              sumDouble.toString() == null
                  ? CircularProgressIndicator()
                  : sumDouble.toString() == 'NaN'
                      ? Text(
                          '0',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )
                      : Text(
                          sumDouble.toString(),
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
              avgStr.toString() == null
                  ? LinearProgressIndicator()
                  : sumDouble.toString() == 'NaN'
                      ? Text('ไม่มีรีวิว')
                      : Text(avgStr.toString()),
              SizedBox(
                height: 10,
              ),
              // sume(),
              // Text(allData.toString()),
              Expanded(child: _buildBody(context))
            ],
          ),
        ),
      ),
    );
  }

  // เพิ่มข้อมูลรีวิว //////////////////////////////////////////////////////////////////////
  // ignore: non_constant_identifier_names
  CollectionReference travel_sea =
      FirebaseFirestore.instance.collection('comment');

  Future<void> addReview() {
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
    DateTime myDateTime = myTimeStamp.toDate(); // TimeStamp to DateTime

    print("current phone data is: $currentPhoneDate");
    print("current phone data is: $myDateTime");
    return travel_sea.add({
      'travelName': widget.travelName,
      'comment': textEditingController.text,
      'pic': widget.picUrl,
      'rate': valued,
      'timeago': myDateTime,
    }).then((value) {
      // ignore:
      print(
          '7777777777777777777------------------------555555555-------------777777777' +
              widget.travelName);
      print(
          "3636363636363636363636363636363636363636363636363636363636363636User Added" +
              textEditingController.text);
      print('xxxxxxxxxxxxxxxxxxxxxxxxxxx' + valued.toString());
      Fluttertoast.showToast(
        msg: "รีวิวสำเร็จ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.purple[100],
        textColor: Colors.black,
      );

      // ignore: avoid_print, invalid_return_type_for_catch_error
    }).catchError((error) => print("Failed to add user: $error"));
  }
}

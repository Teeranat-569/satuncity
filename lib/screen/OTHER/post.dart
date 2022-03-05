import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Post extends StatefulWidget {
  const Post({Key key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final _formKey = GlobalKey<FormState>();
  String comments;
  double valued;
  var rating = 0.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      
                      Padding(
                        padding: EdgeInsets.only(top: 50, left: 20),
                        child: TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                labelText: "Leave a Comment..",
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                )),
                            onSaved: (value) {
                              comments = value;
                            }),
                      ),
                    ],
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // MyStyle().sizedBox20(),
                  // Text('โปรดให้คะแนนการซ่อมบำรุงเพื่อประเมินความพึงพอใจ'),
                  // SizedBox(height: 50),
                  Center(
                      child: SmoothStarRating(
                    borderColor: Colors.white,
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
                  RaisedButton(
                    color: Colors.white,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: () {
                      // ignore: unnecessary_brace_in_string_interps
                      print('Send_Rate${valued}');
                      // route(Bar());
                      // updateStatus();
                      Fluttertoast.showToast(
                        msg: "ให้คะแนนสำเร็จ",
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.pink[200],
                        textColor: Colors.black,
                        fontSize: 16,
                      );
                    },
                    child: Text(
                      'ส่งคะแนน',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

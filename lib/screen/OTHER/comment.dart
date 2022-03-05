import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommentSection extends StatefulWidget {
  // const CommentSection({Key? key}) : super(key: key);

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  var username = ' ';
  List photoURL = [];

  User user = FirebaseAuth.instance.currentUser;
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');

  final _formKey = GlobalKey<FormState>();
  String comments = ' ';

  sendComment() async {
    final isValid = _formKey.currentState.validate();
    final name = user.displayName;

    var res = await userRef.where('user_id', isEqualTo: user.uid).get();

    _formKey.currentState.save();

    var doc = userRef.doc('photo');
    doc.set({
      'comment': comments,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50),
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
                  )
                ],
              )),
          ElevatedButton.icon(
              onPressed: sendComment,
              icon: Icon(
                Icons.send,
                color: Colors.white,
              ),
              label: Text("Send"))
        ],
      )),
    );
  }
}

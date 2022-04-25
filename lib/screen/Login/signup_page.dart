// ignore_for_file: prefer_const_constructors, unused_field

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:satuncity/screen/home.dart';
import 'customClipper.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = true;
  String _password;

  @override
  // ignore: must_call_super
  void initState() {
    _passwordVisible = false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -MediaQuery.of(context).size.height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: Container(
                  child: Transform.rotate(
                    angle: -pi / 3.5,
                    child: ClipPath(
                      clipper: ClipPainter(),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.blue,
                              Colors.lightBlue,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Image.asset(
                            'images/logo-re.png',
                            height: 150,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Username",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: _usernameController,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.start,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: "username",
                                    suffixIcon: Icon(
                                      Icons.email,
                                      color: Colors.black54,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        15,
                                      ),
                                    ),
                                    // fillColor: Color(
                                    //   0xfff3f3f4,
                                    // ),
                                    // filled: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: _emailController,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.start,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: "email",
                                    suffixIcon: Icon(
                                      Icons.email,
                                      color: Colors.black54,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        15,
                                      ),
                                    ),
                                    // fillColor: Color(
                                    //   0xfff3f3f4,
                                    // ),
                                    // filled: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Password",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // TextField(
                                //   controller: _passwordController,
                                //   style: TextStyle(
                                //     fontSize: 20,
                                //   ),
                                //   textAlign: TextAlign.start,
                                //   obscureText: !obscureText,
                                //   decoration: InputDecoration(
                                //     hintText: "password",
                                //     suffixIcon: IconButton(
                                //       icon: Icon(Icons.visibility),
                                //       onPressed: () {

                                //       },
                                //     ),
                                //     border: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(
                                //         15,
                                //       ),
                                //     ),
                                //     fillColor: Color(
                                //       0xfff3f3f4,
                                //     ),
                                //     filled: true,
                                //   ),
                                // ),

                                TextFormField(
                                  initialValue: _password,
                                  onSaved: (val) => _password = val,
                                  validator: (val) => val.length < 6
                                      ? 'Password too short.'
                                      : 'lll',
                                  keyboardType: TextInputType.text,
                                  controller: _passwordController,
                                  obscureText:
                                      !_passwordVisible, //This will obscure text dynamically
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        15,
                                      ),
                                    ),
                                    labelText: 'Password',
                                    hintText: 'Enter your password',
                                    // Here is key idea
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // ignore: deprecated_member_use
                      FlatButton(
                        onPressed: () {
                          signUp();
                        },
                        child: Container(
                          width: 200,
                          height: 50,
                          color: Colors.blue,
                          child: Center(
                            child: Text(
                              'สมัครสมาชิก',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          padding: EdgeInsets.all(15),
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Text(
                                'มีบัญชีผู้ใช้แล้วใช่ไหม ?',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Login',
                                style: TextStyle(
                                  color: Color(
                                    0xFF0389F6,
                                  ),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 0,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: 0,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Icon(
                            Icons.arrow_left,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                        Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// สมัครสมาชิกด้วยอีเมล-รหัสผ่าน //////////////////////////////////////////////////////////////////////
  Future signUp({dynamic email, dynamic password}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {

      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
     
        final User user = auth.currentUser;
      final String uid = user.uid; 
      String email = user.email;
      addUser(uid,email);
      MaterialPageRoute materialPageRoute = MaterialPageRoute(
          builder: (BuildContext context) => Home(
                username: _emailController.text,
              ));

      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      return  Fluttertoast.showToast(
        msg: e.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        timeInSecForIosWeb: 2
      );
      
    }
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addUser(dynamic uid,dynamic email) {
    // ignore: unnecessary_statements
    return users.add({
      'uid': uid,
      'email': _emailController.text,
      'password': _passwordController.text,
      'username': _usernameController.text,
    }).then((value) {
      Fluttertoast.showToast(
        msg: "สมัครสมาชิกสำเร็จ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.purple[100],
        textColor: Colors.black,
      );
      // MaterialPageRoute materialPageRoute =
      //     MaterialPageRoute(builder: (BuildContext context) => Admin());
      // Navigator.of(context).pushAndRemoveUntil(
      //     materialPageRoute, (Route<dynamic> route) => false);
      // ignore: avoid_print, invalid_return_type_for_catch_error
    }).catchError((error) => print("Failed to add user: $error"));
  }
}

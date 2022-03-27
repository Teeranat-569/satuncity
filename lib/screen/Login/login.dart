// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:satuncity/screen/Login/signup_page.dart';

import '../home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final keyform = GlobalKey<FormState>();
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  dynamic username, password;
  FirebaseAuth firebase = FirebaseAuth.instance;
//  User  user = FirebaseAuth.getInstance().getCurrentUser();

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
      } else {
        print('User is signed in!');
        String uid = user.uid; // <-- User ID
        String email = user.email;
        // String username = user.
        print('kkkkkkkkkkkkkk-------kkkkkkkkk $email');
        print('User is currently signed out!');
        MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext context) => Home(
                  username: email,
                ));

        Navigator.of(context).pushAndRemoveUntil(
            materialPageRoute, (Route<dynamic> route) => false);
      }
    });
    User user = FirebaseAuth.instance.currentUser;

// Check if the user is signed in
    if (user != null) {
      String uid = user.uid; // <-- User ID
      String email = user.email;
      print('kkkkkkkkkkkkkkkkkkkkkkk $email');
      // //   MaterialPageRoute materialPageRoute =
      // //     MaterialPageRoute(builder: (BuildContext context) => LoginPage());

      // // Navigator.of(context)
      // //     .pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
    }
  }

  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Image.asset(
                'images/logo.png',
                height: 150,
              ),
            ),
          ),
          Text(
            'เข้าสู่ระบบ',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 15),
          Form(
              key: keyform,
              child: Column(
                children: [
                  usernameText(),
                  SizedBox(
                    height: 5,
                  ),
                  passwordText()
                ],
              )),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {
                // _onLogin();
                keyform.currentState.save();
                checkAuthen();
                // ignore: avoid_print
                print(
                    'pppppppppppppppppuuuuuuuuuuuuuuuuuppppppppppppp$username');
                // ignore: avoid_print
                print('pppppppppppppppppppppppppppppp$password');
              },
              color: Colors.blue[200],
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Login",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 20),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text("Or Sign in with"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => facebookLogin(),
                child: Image.asset(
                  'images/facebook.png',
                  height: 45,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('หากยังไม่มีบัญชีผู้ใช้'),
              SizedBox(
                width: 15,
              ),
              FlatButton(
                  color: Colors.blue.shade100,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                  onPressed: () {
                    MaterialPageRoute materialPageRoute = MaterialPageRoute(
                        builder: (BuildContext context) => SignUpPage());
                    Navigator.of(context).push(materialPageRoute);
                  },
                  child: Text(
                    'สมัครสมาชิก',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
            ],
          )
        ])),
      ),
    ));
  }

  Widget usernameText() {
    return TextField(
      onChanged: (value) => username = value.trim(),
      controller: userController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Email',
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

  Widget passwordText() {
    return TextField(
      onChanged: (value) => password = value.trim(),
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Password',
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

  Future<void> facebookLogin() async {
    final result = await FacebookAuth.instance
        .login(permissions: ["email", "public_profile"]);

    if (result.status == LoginStatus.success) {
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken.token);

      final userObj =
          await FirebaseAuth.instance.signInWithCredential(credential);

      print("Facebook Data with Credentials -> ${userObj.user.toString()}");

      final email = userObj.user.providerData[0].email;

      final displayName = userObj.user.providerData[0].displayName;
    } else {
      print('///////////////////////////ffffffff');
    }
  }

  Future<Null> checkAuthen() async {
    await Firebase.initializeApp().then((value) {
      // ignore: avoid_print
      print('******************************');
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      firebaseAuth
          .signInWithEmailAndPassword(email: username, password: password)
          .then((response) {
        print('***********************' + username);
        // ignore: avoid_print
        if (username == 'satuncity-app@gmail.com') {
          Fluttertoast.showToast(
            msg: "บัญชีผู้ดูแลระบบ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green[100],
            textColor: Colors.black,
          );
          MaterialPageRoute materialPageRoute = MaterialPageRoute(
              builder: (BuildContext context) => Home(
                    username: username,
                  ));
          Navigator.of(context).pushAndRemoveUntil(
              materialPageRoute, (Route<dynamic> route) => false);
        } else {
          print('Authen Success');
          Fluttertoast.showToast(
            msg: "เข้าสู่ระบบสำเร็จ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Color.fromRGBO(149, 200, 215, 1.0),
            textColor: Colors.black,
          );

          MaterialPageRoute materialPageRoute = MaterialPageRoute(
              builder: (BuildContext context) => Home(
                    username: username,
                  ));
          Navigator.of(context).pushAndRemoveUntil(
              materialPageRoute, (Route<dynamic> route) => false);
        }
      }).catchError((response) {
        String title = response.code;
        String message = response.message;
        myAlert(title, message);
      });
    });
  }

  void myAlert(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // ignore: duplicate_ignore
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              FlatButton(onPressed: () {}, child: const Text('ok'))
            ],
          );
        });
  }
}

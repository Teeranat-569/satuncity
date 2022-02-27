// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:satuncity/screen/conterller/auth_controller.dart';

import '../admin/admin.dart';
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
  // AuthController authController;

  // Map<String, dynamic> _userData;
  // String welcome = "Facebook";
//  final LoginResult result = await FacebookAuth.instance.login(permissions:['email']);

  // void _onLogin() {
  //   if (keyform.currentState.validate()) {
  //     keyform.currentState.save();
  //     // authController.onLogin(
  //     //     email: userController.text, password: passwordController.text);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // authController = AuthController(context);
  }

  @override
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
                  // _createInput(controller: userController, hintText: 'e-mail',),
                  // _createInput(
                  //     controller: passwordController,
                  //     hintText: 'password',
                  //     isPassword: true)
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
                // onTap: () => authController.loginWithFacebook(context),
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
                  width: 2, color: Colors.grey[400], style: BorderStyle.solid)),
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
                  width: 2, color: Colors.grey[400], style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }

  // Widget _createInput(
  //     {@required TextEditingController controller,
  //     @required String hintText,
  //     TextInputType keyboardType = TextInputType.text,
  //     bool isPassword = false,dynamic onChanged,}) {
  //   return
  // Container(
  //     decoration: BoxDecoration(boxShadow: [
  //       BoxShadow(offset: Offset.zero, color: Colors.grey, blurRadius: 8)
  //     ]),
  //     margin: EdgeInsets.symmetric(vertical: 8),
  //     child: TextFormField(
  //       controller: controller,
  //       keyboardType: keyboardType,
  //       obscureText: isPassword,
  //        onChanged: (value) => onChanged = value.trim(),
  //       validator: (msg) {
  //         if (msg.isEmpty) return 'Input InValid';

  //         return null;
  //       },
  //       decoration: InputDecoration(
  //           hintText: hintText,
  //           filled: true,
  //           fillColor: Colors.white,
  //           enabledBorder: OutlineInputBorder(
  //               borderSide: BorderSide(
  //                   width: 2,
  //                   color: Colors.grey[400],
  //                   style: BorderStyle.solid)),
  //           focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
  //     ),
  //   );
  // }

  Future<void> facebookLogin() async {
    final result = await FacebookAuth.instance
        .login(permissions: ["email", "public_profile"]);

    if (result.status == LoginStatus.success) {
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken.token);

      final userObj =
          await FirebaseAuth.instance.signInWithCredential(credential);

      print("Facebook Data with Credentials -> ${userObj.user.toString()}");

      // ignore: unused_local_variable
      final email = userObj.user.providerData[0].email;

      // ignore: unused_local_variable
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
          MaterialPageRoute materialPageRoute =
              MaterialPageRoute(builder: (BuildContext context) => Home(username: username,));
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

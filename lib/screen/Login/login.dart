import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:satuncity/screen/conterller/auth_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final keyform = GlobalKey<FormState>();
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  AuthController authController;

  void _onLogin() {
    if (keyform.currentState.validate()) {
      keyform.currentState.save();
      authController.onLogin(
          email: userController.text, password: passwordController.text);
    }
  }

  @override
  void initState() {
    super.initState();
    authController = AuthController(context);
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
          Text('เข้าสู่ระบบ', style: Theme.of(context).textTheme.headline6),
          SizedBox(height: 15),
          Form(
              key: keyform,
              child: Column(
                children: [
                  _createInput(controller: userController, hintText: 'e-mail'),
                  _createInput(
                      controller: passwordController,
                      hintText: 'password',
                      isPassword: true)
                ],
              )),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {
                _onLogin();
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
                onTap: () => authController.loginWithFacebook(context),
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

  Widget _createInput(
      {@required TextEditingController controller,
      @required String hintText,
      TextInputType keyboardType = TextInputType.text,
      bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(offset: Offset.zero, color: Colors.grey, blurRadius: 8)
      ]),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        validator: (msg) {
          if (msg.isEmpty) return 'Input InValid';

          return null;
        },
        decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2,
                    color: Colors.grey[400],
                    style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }
}

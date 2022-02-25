import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthController {
  final BuildContext _context;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthController(BuildContext context) : _context = context;

  onLogin({@required String email, @required String password}) async {
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushReplacementNamed(_context, '/home');
    } catch (e) {
      final _e = (e as FirebaseAuthException);
      print(_e.message);
    }
  }

  FacebookLogin facebookLogin = FacebookLogin();

  Future loginWithFacebook(BuildContext context) async {
    FacebookLoginResult result =
        await facebookLogin.logIn(['email', "public_profile"]);

    String token = result.accessToken.token;
    print("Access token = $token");
    await _firebaseAuth
        .signInWithCredential(FacebookAuthProvider.credential("${token}"));

    Navigator.pushReplacementNamed(_context, '/home');
  }

  Future<void> logout() async {
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();

    Navigator.pushReplacementNamed(_context, '/login');
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignInProvider extends ChangeNotifier {
  bool _isLogged = false;
  Map userObj = {};

  bool get isLogged => _isLogged;

  Future facebookLogout() async {
    FacebookAuth.instance.logOut().then((value) {
      _isLogged = false;
      userObj = {};
    });
  }

  Future facebookLogin() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]);

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

    FacebookAuth.instance.getUserData().then((userData) async {
      _isLogged = true;
      userObj = userData;
    });

    notifyListeners();
  }

  String? getImage() {
    if (userObj != {}) {
      return userObj['picture']['data']['url'];
    }
    return null;
  }
}

import 'package:app_pizzeria/helper.dart';
import 'package:app_pizzeria/widget/user_widget/my_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignInProvider extends ChangeNotifier {
  bool _isLogged = false;
  Map userObj = {};

  bool get isLogged => _isLogged;

  void setIsLogged(bool logged) {
    _isLogged = logged;
  }

  Future facebookLogout() async {
    FacebookAuth.instance.logOut().then((value) {
      _isLogged = false;
      userObj = {};
    });
  }

  Future facebookLogin(BuildContext context) async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance
          .login(permissions: ["public_profile", "email"]);

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      final data = await FacebookAuth.instance.getUserData();

      _isLogged = true;
      userObj = data;
    } on FirebaseAuthException catch (e) {
      String error = e.code;

      if (e.code == 'email-already-in-use' ||
          e.code == 'account-exists-with-different-credential') {
        error = "Email già utilizzata";
      } else {
        if (kDebugMode) {
          print(error);
        }
      }

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      MySnackBar.showMySnackBar(context, error);

      return;
    }

    saveRegType("facebook");
    notifyListeners();
  }

  String? getImage() {
    if (userObj != {}) {
      return userObj['picture']['data']['url'];
    }
    return null;
  }
}

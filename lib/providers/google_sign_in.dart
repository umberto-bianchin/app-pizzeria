import 'package:app_pizzeria/helper.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  bool _isLogged = false;

  GoogleSignInAccount get user => _user!;
  bool get isLogged => _isLogged;

  void setIsLogged(bool logged) async {
    _isLogged = logged;

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
  }

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      saveRegType("google");
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    _isLogged = true;
    notifyListeners();
  }

  Future googleLogout() async {
    _isLogged = false;
    await googleSignIn.disconnect();
  }

  String? getImage() {
    if (_user != null) {
      return _user!.photoUrl;
    }
    return null;
  }
}

import 'package:app_pizzeria/providers/facebook_provider.dart';
import 'package:app_pizzeria/providers/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

enum LoginType { google, facebook, apple, email }

LoginType getLogInType(BuildContext ctx) {
  final googleProvider = Provider.of<GoogleSignInProvider>(ctx, listen: false);
  final facebookProvider =
      Provider.of<FacebookSignInProvider>(ctx, listen: false);

  if (googleProvider.isLogged) {
    return LoginType.google;
  }
  if (facebookProvider.isLogged) {
    return LoginType.facebook;
  }
  return LoginType.email;
}

void logOut(BuildContext ctx) {
  final googleProvider = Provider.of<GoogleSignInProvider>(ctx, listen: false);
  final facebookProvider =
      Provider.of<FacebookSignInProvider>(ctx, listen: false);

  LoginType type = getLogInType(ctx);

  switch (type) {
    case LoginType.google:
      googleProvider.googleLogout();
      break;
    case LoginType.facebook:
      facebookProvider.facebookLogout();
      break;
    case LoginType.apple:
      break;
    default:
      break;
  }

  FirebaseAuth.instance.signOut();
}

ImageProvider getImage(BuildContext ctx) {
  final googleProvider = Provider.of<GoogleSignInProvider>(ctx, listen: false);
  final facebookProvider =
      Provider.of<FacebookSignInProvider>(ctx, listen: false);

  LoginType type = getLogInType(ctx);

  switch (type) {
    case LoginType.google:
      return NetworkImage(googleProvider.getImage()!);
    case LoginType.facebook:
      return NetworkImage(facebookProvider.getImage()!);
    case LoginType.apple:
    default:
      return const AssetImage("assets/images/user_default.png");
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper.dart';

class UserInfoProvider with ChangeNotifier {
  String number = "";
  String address = "";
  String token = "";
  bool isLoggedin = FirebaseAuth.instance.currentUser != null;

  void submitInfos({required String number, required String address}) {
    if (number != this.number || address != this.address) {
      this.number = number;
      this.address = address;
      saveUserInfos(address: address, phone: number);
    }
  }

  void getUser(BuildContext ctx) async {
    Map<String, String> information = await getUserInfo();
    number = information["phone"] ?? "";
    address = information["address"] ?? "";
    token = information["token"] ?? "";

    if (ctx.mounted) {
      setLogInType(information["type"] ?? "email", ctx);
    }
    isLoggedin = true;
  }

  void addToken(String token) {
    if (token != this.token) {
      this.token = token;
      saveToken(token);
    }
  }

  void logOut() {
    number = "";
    address = "";
    isLoggedin = false;
  }
}

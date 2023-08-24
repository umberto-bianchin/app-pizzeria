import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper.dart';

class UserInfoProvider with ChangeNotifier {
  String number = "";
  String address = "";
  String token = "";
  String name = "";
  bool isLoggedin = FirebaseAuth.instance.currentUser != null;

  void submitInfos(
      {required String number, required String address, required String name}) {
    if (number != this.number || address != this.address || name != this.name) {
      this.number = number;
      this.address = address;
      this.name = name;
      saveUserInfos(address: address, phone: number, name: name);
    }
  }

  void getUser(BuildContext ctx) async {
    Map<String, String> information = await getUserInfo();
    number = information["phone"] ?? "";
    address = information["address"] ?? "";
    token = information["token"] ?? "";
    name = information["name"] ?? "";

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

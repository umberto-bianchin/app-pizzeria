import 'package:flutter/material.dart';

import '../helper.dart';

class UserInfoProvider with ChangeNotifier {
  String number = "";
  String address = "";
  String token = "";
  bool isLoggedin = false;

  void submitInfos({required String number, required String address}) {
    if (number != this.number || address != this.address) {
      this.number = number;
      this.address = address;
      saveUserInfos(address: address, phone: number);
    }
  }

  void getUser() async {
    Map<String, String> information = await getUserInfo();
    number = information["phone"]!;
    address = information["address"]!;
    token = information["token"]!;
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

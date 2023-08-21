import 'package:flutter/material.dart';

import '../helper.dart';

class UserInfoProvider with ChangeNotifier {
  String number = "";
  String address = "";
  bool isLoggedin = false;

  void submitInfos({required String number, required String address}) {
    this.number = number;
    this.address = address;
    saveUserInfos(address: address, phone: number);
  }

  void getUser() async {
    Map<String, String> information = await getUserInfo();
    number = information["phone"]!;
    address = information["address"]!;
    isLoggedin = true;
  }

  void logOut() {
    number = "";
    address = "";
    isLoggedin = false;
  }

}

import 'package:flutter/material.dart';

import '../helper.dart';

class UserInfoProvider with ChangeNotifier {
  String number = "";
  String address = "";
  bool valid = false;

  void submitInfos({required String number, required String address}) {
    this.number = number;
    this.address = address;
    valid = number == "" || address == "" ? false : true;
    saveUserInfos(address: address, phone: number);
  }

  void getUser() async {
    Map<String, String> information = await getUserInfo();
    number = information["phone"]!;
    address = information["address"]!;
    valid = number == "" || address == "" ? false : true;
  }
}

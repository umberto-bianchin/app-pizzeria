import 'package:app_pizzeria/providers/cart_provider.dart';
import 'package:app_pizzeria/providers/facebook_provider.dart';
import 'package:app_pizzeria/providers/google_sign_in.dart';
import 'package:app_pizzeria/providers/user_infos_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'data/data_item.dart';
import 'data/menu_items_list.dart';

enum LoginType { google, facebook, apple, email }

final firestoreInstance = FirebaseFirestore.instance;

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
  Provider.of<UserInfoProvider>(ctx, listen: false).logOut();
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

void saveUserInfos({required String address, required String phone}) {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  firestoreInstance
      .collection("users")
      .doc(firebaseUser!.uid)
      .collection("infos")
      .doc("information")
      .set({
    "address": address,
    "phone": phone,
  }, SetOptions(merge: true));
}

void saveToken(String token) {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  firestoreInstance
      .collection("users")
      .doc(firebaseUser!.uid)
      .collection("infos")
      .doc("information")
      .set({
    "token": token,
  }, SetOptions(merge: true));
}

Future<Map<String, String>> getUserInfo() async {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  var snapshot = await firestoreInstance
      .collection("users")
      .doc(firebaseUser!.uid)
      .collection("infos")
      .doc("information")
      .get();

  if (snapshot.exists) {
    return {
      "address": snapshot.data()!["address"],
      "phone": snapshot.data()!["phone"],
    };
  }
  return {
    "address": "",
    "phone": "",
  };
}

void submitOrder(
  BuildContext ctx, {
  required String timeInterval,
  required CartItemsProvider order,
}) {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  Map<String, dynamic> jsonOrder = {};
  int index = 0;

  jsonOrder["accepted"] = "False";
  jsonOrder["time-interval"] = timeInterval;
  jsonOrder["total"] = order.getTotal().toStringAsFixed(2);
  jsonOrder["delivery-method"] = order.deliveryMethod;

  for (DataItem item in order.cartList) {
    jsonOrder["ordine$index"] = {
      "name": item.name,
      "quantity": item.quantity,
      "ingredients":
          item.ingredients.map((ingr) => toStringIngredients(ingr)).join(', '),
    };
    index++;
  }

  firestoreInstance
      .collection("users")
      .doc(firebaseUser!.uid)
      .collection("orders")
      .doc("order")
      .set(jsonOrder);

  order.submitOrder();
}

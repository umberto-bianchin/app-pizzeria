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

void setLogInType(String type, BuildContext ctx) {
  if (type == "google") {
    Provider.of<GoogleSignInProvider>(ctx, listen: false).setIsLogged(true);
    return;
  }
  if (type == "facebook") {
    Provider.of<FacebookSignInProvider>(ctx, listen: false).setIsLogged(true);
    return;
  }
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
  Provider.of<CartItemsProvider>(ctx, listen: false).clearCart();
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
  final firebaseUser = FirebaseAuth.instance.currentUser;
  firestoreInstance.collection("users").doc(firebaseUser!.uid).set({
    "address": address,
    "phone": phone,
  }, SetOptions(merge: true));
}

void saveToken(String token) {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  firestoreInstance.collection("users").doc(firebaseUser!.uid).set({
    "token": token,
  }, SetOptions(merge: true));
}

void saveRegType(String type) {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  firestoreInstance.collection("users").doc(firebaseUser!.uid).set({
    "type": type,
  }, SetOptions(merge: true));
}

Future<Map<String, String>> getUserInfo() async {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  final snapshot =
      await firestoreInstance.collection("users").doc(firebaseUser!.uid).get();

  if (snapshot.exists) {
    return {
      "address": snapshot.data()?["address"] ?? "",
      "phone": snapshot.data()?["phone"] ?? "",
      "type": snapshot.data()?["type"] ?? "email",
    };
  }
  return {"address": "", "phone": "", "type": "email"};
}

void retrieveOrder(BuildContext context) async {
  final firebaseUser = FirebaseAuth.instance.currentUser;

  final snapshot = await firestoreInstance
      .collection("users")
      .doc(firebaseUser!.uid)
      .collection("orders")
      .doc("order")
      .get();

  List<DataItem> list = [];

  if (snapshot.exists) {
    Map<String, dynamic> data = snapshot.data()!;

    if (!context.mounted) return;

    Provider.of<CartItemsProvider>(context, listen: false).deliveryMethod =
        data["delivery-method"];
    Provider.of<CartItemsProvider>(context, listen: false).orderPrice =
        double.parse(data["total"]);
    Provider.of<CartItemsProvider>(context, listen: false).time =
        data["time-interval"];
    Provider.of<CartItemsProvider>(context, listen: false).updateState();
    Provider.of<CartItemsProvider>(context, listen: false).ordered = true;

    // Iterate through fields with "ordine" prefix
    int orderIndex = 0;
    while (data.containsKey('ordine$orderIndex')) {
      final Map<String, dynamic> field = data['ordine$orderIndex'];
      list.add(DataItem(
          key: UniqueKey(),
          image: information[field["name"]]![2],
          name: field["name"],
          ingredients: getIngredients(field["ingredients"]),
          initialPrice: information[field["name"]]![0],
          category: information[field["name"]]![1],
          quantity: field["quantity"]));

      orderIndex++;
    }
  }

  if (!context.mounted) return;

  Provider.of<CartItemsProvider>(context, listen: false).cartList = list;
  Provider.of<CartItemsProvider>(context, listen: false).orderList = list;
}

List<Ingredients> getIngredients(String ingredients) {
  List<String> ingr = ingredients.split(', ');
  return ingr
      .map((ingred) => Ingredients.values
          .firstWhere((e) => e.toString() == 'Ingredients.$ingred'))
      .toList();
}

void submitOrder(
  BuildContext ctx, {
  required String timeInterval,
  required CartItemsProvider order,
}) {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  final Map<String, dynamic> jsonOrder = {};
  int index = 0;

  jsonOrder["accepted"] = "False";
  jsonOrder["time-interval"] = timeInterval;
  jsonOrder["total"] = order.getTotal().toStringAsFixed(2);
  jsonOrder["delivery-method"] = order.deliveryMethod;

  for (DataItem item in order.cartList) {
    jsonOrder["ordine$index"] = {
      "name": item.name,
      "quantity": item.quantity,
      "ingredients": item.ingredients.map((ingr) => ingr.name).join(', '),
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

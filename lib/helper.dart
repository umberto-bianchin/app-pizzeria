import 'package:app_pizzeria/providers/cart_provider.dart';
import 'package:app_pizzeria/providers/facebook_provider.dart';
import 'package:app_pizzeria/providers/google_sign_in.dart';
import 'package:app_pizzeria/providers/menu_provider.dart';
import 'package:app_pizzeria/providers/user_infos_provider.dart';
import 'package:app_pizzeria/widget/menu_widget/categories_buttons_tab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'data/data_item.dart';

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

void saveUserInfos(
    {required String address, required String phone, required String name}) {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  firestoreInstance.collection("users").doc(firebaseUser!.uid).set(
      {"address": address, "phone": phone, "name": name},
      SetOptions(merge: true));
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

void saveInfoEmpty(String info) {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  firestoreInstance.collection("users").doc(firebaseUser!.uid).set({
    info: "",
  }, SetOptions(merge: true));
}

Future<Map<String, String>> getUserInfo() async {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  final snapshot =
      await firestoreInstance.collection("users").doc(firebaseUser!.uid).get();

  final information = ["address", "phone", "type", "name"];

  if (snapshot.exists) {
    for (String info in information) {
      if (snapshot.data()?[info] == null) {
        saveInfoEmpty(info);
      }
    }

    return {
      "address": snapshot.data()?["address"] ?? "",
      "phone": snapshot.data()?["phone"] ?? "",
      "type": snapshot.data()?["type"] ?? "email",
      "name": snapshot.data()?["name"] ?? "",
    };
  }

  for (String info in information) {
    saveInfoEmpty(info);
  }

  return {"address": "", "phone": "", "type": "email", "name": ""};
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
        data["total"].toDouble();
    if (Provider.of<CartItemsProvider>(context, listen: false).confirmed) {
      Provider.of<CartItemsProvider>(context, listen: false).orderTotalPrice =
          data["price"].toDouble();
    }
    if (Provider.of<CartItemsProvider>(context, listen: false).confirmed &&
        Provider.of<CartItemsProvider>(context, listen: false).deliveryMethod ==
            "Domicilio") {
      Provider.of<CartItemsProvider>(context, listen: false).deliveryPrice =
          data["delivery-price"].toDouble();
    }

    Provider.of<CartItemsProvider>(context, listen: false).time =
        data["time-interval"];
    Provider.of<CartItemsProvider>(context, listen: false).updateOrder();
    Provider.of<CartItemsProvider>(context, listen: false).ordered = true;

    // Iterate through fields with "ordine" prefix
    int orderIndex = 0;
    while (data.containsKey('ordine$orderIndex')) {
      final Map<String, dynamic> field = data['ordine$orderIndex'];

      DataItem baseItem = Provider.of<MenuProvider>(context, listen: false)
          .menu
          .firstWhere((element) => element.name == field["name"]);

      list.add(DataItem(
          key: UniqueKey(),
          image: baseItem.image,
          name: baseItem.name,
          ingredients: field["ingredients"].toLowerCase().split(", "),
          initialPrice: baseItem.initialPrice,
          category: baseItem.category,
          quantity: field["quantity"]));

      orderIndex++;
    }
  }

  if (!context.mounted) return;

  Provider.of<CartItemsProvider>(context, listen: false).cartList = list;
  Provider.of<CartItemsProvider>(context, listen: false).orderList = list;
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
  jsonOrder["total"] = order.getTotal(ctx);
  jsonOrder["delivery-method"] = order.deliveryMethod;

  for (DataItem item in order.cartList) {
    jsonOrder["ordine$index"] = {
      "name": item.name.toLowerCase(),
      "quantity": item.quantity,
      "ingredients":
          item.ingredients.map((ingr) => ingr.toLowerCase()).join(', '),
    };
    index++;
  }

  firestoreInstance
      .collection("users")
      .doc(firebaseUser!.uid)
      .collection("orders")
      .doc("order")
      .set(jsonOrder);

  order.submitOrder(ctx);
}

Future<void> deleteOrder(BuildContext context) async {
  Provider.of<CartItemsProvider>(context, listen: false).clearCart();

  final firebaseUser = FirebaseAuth.instance.currentUser;
  await FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseUser!.uid)
      .collection("orders")
      .doc("order")
      .delete();
}

Future<List<DataItem>> getMenu() async {
  final List<DataItem> menu = [];

  final snapshot =
      await FirebaseFirestore.instance.collection('menu').doc("elements").get();

  final menuData = snapshot.data();

  if (menuData != null) {
    for (String element in menuData.keys) {
      Categories category = Categories.values
          .firstWhere((value) => value.name == menuData[element]["category"]);

      if (menuData[element]["available"]) {
        menu.add(
          DataItem(
              key: UniqueKey(),
              name:
                  element.substring(0, 1).toUpperCase() + element.substring(1),
              ingredients: menuData[element]["ingredients"].split(", "),
              initialPrice: menuData[element]["price"].toDouble(),
              category: category,
              image: NetworkImage(menuData[element]["imageUrl"]),
              important: menuData[element]["important"]),
        );
      }
    }
  }

  return menu;
}

Future<Map<String, double>> getSavedIngredients() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('menu')
      .doc("ingredients")
      .get();

  Map<String, double> ingredientsMap = {};
  if (snapshot.data() != null) {
    snapshot.data()!.forEach((key, value) {
      if (value[1]) {
        ingredientsMap[key.substring(0, 1).toUpperCase() + key.substring(1)] =
            value[0].toDouble();
      }
    });
  }

  return ingredientsMap;
}

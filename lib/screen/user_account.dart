import 'package:flutter/material.dart';

import '../data/data_item.dart';
import '../helper.dart';

class UserAccountScreen extends StatefulWidget {
  const UserAccountScreen({super.key});

  @override
  State<UserAccountScreen> createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  TextEditingController? _addressController;
  TextEditingController? _phoneController;
  final Map<String, String> infos = {};

  @override
  void initState() {
    super.initState();
    getInfos();
  }

  void getInfos() async {
    Map<String, String> information = await getUserInfo();
    setState(() {
      infos.addAll(information);
      _addressController = TextEditingController(text: infos["address"]);
      _phoneController = TextEditingController(text: infos["phone"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kprimaryColor,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 30, top: 30, right: 30),
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: kprimaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Il mio account",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.streetAddress,
                  controller: _addressController,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: const Color.fromARGB(255, 231, 231, 231),
                    filled: true,
                    hintText: "Inserisci l'indirizzo per la consegna",
                    hintStyle: TextStyle(color: Colors.grey[500]),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: const Color.fromARGB(255, 231, 231, 231),
                    filled: true,
                    hintText: "Inserisci il numero di telefono",
                    hintStyle: TextStyle(color: Colors.grey[500]),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  saveUserInfos(
                      address: _addressController!.text,
                      phone: _phoneController!.text);
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  fixedSize: const Size(120, 20),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  "Salva",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

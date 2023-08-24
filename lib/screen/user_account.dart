import 'package:app_pizzeria/screen/location_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_infos_provider.dart';

class UserAccountScreen extends StatefulWidget {
  const UserAccountScreen({super.key});

  @override
  State<UserAccountScreen> createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  String? _address = "";
  TextEditingController? _usernameController;

  TextEditingController? _phoneController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getInfos();
  }

  void setAdress(String address) {
    setState(() {
      _address = address;
    });
  }

  void getInfos() {
    if (context.mounted) {}

    setState(() {
      final info = Provider.of<UserInfoProvider>(context, listen: false);
      _address = info.address;
      _usernameController = TextEditingController(text: info.name);
      _phoneController = TextEditingController(text: info.number);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 30, top: 30, right: 30),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: Theme.of(context).primaryColor),
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
                    Text(
                      "Il mio account",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationPicker(setAdress),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    foregroundColor: const Color.fromARGB(255, 53, 126, 56),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            text: _address!.isEmpty
                                ? "Seleziona il tuo indirizzo"
                                : _address!,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const Icon(Icons.map_rounded),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if ((value!.length != 10 && value.length != 9) ||
                          !isNumeric(value)) {
                        return "Inserisci un numero di telefono valido";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      hintText: "Inserisci il numero di telefono",
                      suffixIcon: const Icon(Icons.phone),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  controller: _usernameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    hintText: "Inserisci il tuo nome",
                    suffixIcon: const Icon(Icons.person_outlined),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Provider.of<UserInfoProvider>(context, listen: false)
                        .submitInfos(
                            address: _address!,
                            number: _phoneController!.text,
                            name: _usernameController!.text);
                    Navigator.pop(context);
                  }
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool isNumeric(String str) {
  return int.tryParse(str) != null;
}

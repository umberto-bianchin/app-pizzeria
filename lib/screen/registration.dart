import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/data_item.dart';
import '../main.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kprimaryColor,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(children: [
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
                    "Registrazione",
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
            Expanded(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  // welcome back, you've been missed!
                  Text(
                    'Benvenuto!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 25),

                  // username textfield
                  textField(
                    emailController,
                    'Email',
                    false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  textField(
                    passwordController,
                    'Password',
                    true,
                  ),

                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    height: 60,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      icon: const Icon(
                        Icons.lock_open,
                        size: 32,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Registrati",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        signUp();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future signUp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print(e.code);
      }
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

Widget textField(controller, final String hintText, final bool obscureText) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      obscureText: obscureText,
      validator: (value) =>
          EmailValidator.validate(value!) ? null : "Inserisci una mail valida",
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500])),
    ),
  );
}

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
  final validatePasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
              child: Form(
                key: formKey,
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
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        controller: validatePasswordController,
                        autocorrect: false,
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value != passwordController.text) {
                            return 'Password incorretta';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            hintText: 'Conferma password',
                            hintStyle: TextStyle(color: Colors.grey[500])),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
            ),
          ]),
        ),
      ),
    );
  }

  Future signUp() async {
    FocusScope.of(context).unfocus();
    if (!formKey.currentState!.validate()) return;

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
      String error = e.code;

      if (e.code == 'email-already-in-use') {
        error = "Email già utilizzata";
      } else if (e.code == 'weak-password') {
        error = "Password debole";
      } else {
        //print(e.code);
      }

      Navigator.pop(context);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          closeIconColor: Colors.red,
          content: Text(error),
        ),
      );
      return;
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

String? validateMail(String? email) {
  if (!EmailValidator.validate(email!)) {
    return "Inserisci una mail valida";
  } else {
    return null;
  }
}

String? validatePassword(String? password) {
  if (password!.length < 6) {
    return "Inserisci una password con almeno 6 caratteri";
  } else {
    return null;
  }
}

bool isPasswordCorrect(String? password, String? confirmPassword) {
  return password == confirmPassword;
}

Widget textField(controller, final String hintText, final bool obscureText) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: TextFormField(
      keyboardType:
          obscureText ? TextInputType.emailAddress : TextInputType.text,
      autocorrect: false,
      controller: controller,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (obscureText) {
          return validatePassword(value);
        } else {
          return validateMail(value);
        }
      },
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

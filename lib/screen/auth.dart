import 'package:app_pizzeria/screen/registration.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/data_item.dart';
import '../main.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: kprimaryColor),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.lock,
                size: 30,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              const SizedBox(height: 30),

              // welcome back, you've been missed!
              Text(
                'Bentornato, ci sei mancato!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
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

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: const ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll<Color>(Colors.grey)),
                      onPressed: () {
                        //TODO
                      },
                      child: const Text('Password dimenticata?'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),
              // sign in button
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
                    "Autenticati",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    signIn();
                  },
                ),
              ),

              const SizedBox(height: 20),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Oppure continua con',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // google + apple sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/images/google.png',
                      width: 60,
                      height: 60,
                    ),
                  ),

                  const SizedBox(width: 25),

                  // apple button
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/images/apple.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // not a member? register now
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Non sei ancora registrato?',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegistrationScreen()));
                  },
                  child: const Text(
                    'Registrati ora',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ]),
            ],
          ),
        ),
      ],
    );
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
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

Widget squareTile(final String imagePath) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(16),
      color: Colors.grey[200],
    ),
    child: Image.asset(
      imagePath,
      height: 40,
    ),
  );
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

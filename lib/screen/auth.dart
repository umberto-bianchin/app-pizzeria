import 'package:app_pizzeria/providers/google_sign_in.dart';
import 'package:app_pizzeria/screen/registration.dart';
import 'package:app_pizzeria/widget/my_snackbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/data_item.dart';
import '../main.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final backupEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
          child: Form(
            key: formKey,
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
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  alignment: Alignment.center,
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Password dimenticata?',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      IconButton(
                                          icon: const Icon(Icons.close),
                                          color: const Color(0xFF1F91E7),
                                          onPressed: () {
                                            backupEmailController.clear();
                                            Navigator.of(context).pop();
                                          })
                                    ],
                                  ),
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 25, right: 20, bottom: 20),
                                      child: Text(
                                          'Ricevi una mail per effettuare il reset della tua password'),
                                    ),
                                    textField(
                                      backupEmailController,
                                      'Email',
                                      false,
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      height: 40,
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                        ),
                                        icon: const Icon(
                                          Icons.email_outlined,
                                          size: 32,
                                          color: Colors.white,
                                        ),
                                        label: const Text(
                                          "Reset password",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        onPressed: () {
                                          verifyEmail();
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: const Text('Password dimenticata?'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),
                // sign in button
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
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();
                      },
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
                        'assets/images/facebook.png',
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
        ),
      ],
    );
  }

  Future signIn() async {
    FocusScope.of(context).unfocus();

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
      String error = e.code;

      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        error = "Credenziali errate";
      } else {
        //print(e.code);
      }

      Navigator.pop(context);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      MySnackBar.showMySnackBar(context, error);
      return;
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future verifyEmail() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: backupEmailController.text.trim());

      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        MySnackBar.showMySnackBar(context, 'Email inviato');
      }
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      String error = e.code;

      if (e.code == 'user-not-found') {
        error = "Nessun utente registrato con questa mail";
      } else if (e.code == 'missing-email') {
        error = "Inserire la mail per il reset della password";
      } else {}

      Navigator.of(context).pop();
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      MySnackBar.showMySnackBar(context, error);
    }
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
      keyboardType:
          obscureText ? TextInputType.emailAddress : TextInputType.text,
      autocorrect: false,
      controller: controller,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => obscureText || EmailValidator.validate(value!)
          ? null
          : "Inserisci una mail valida",
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

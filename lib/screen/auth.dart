/// This file contains the code for the authentication screen of the Flutter app.
///
/// The [AuthScreen] class is a stateful widget that provides UI elements for user
/// authentication including login, password reset, and social sign-ins.
///
/// It imports necessary packages and files, and defines various text fields and buttons.
///
/// The [signIn] function handles the sign in process using Firebase Authentication.
/// The [resetPassword] function handles the password reset process using Firebase Authentication.
///
/// The [squareTile] function defines a widget for displaying square tiles with an image.
/// The [textField] function defines a widget for displaying text input fields.
///

import 'package:app_pizzeria/providers/google_sign_in.dart';
import 'package:app_pizzeria/screen/registration.dart';
import 'package:app_pizzeria/widget/user_widget/top_screen.dart';
import 'package:app_pizzeria/widget/user_widget/my_snackbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../providers/facebook_provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Controllers for text fields.
  final emailController = TextEditingController();
  final backupEmailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final resetKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopBanner(
          title: 'Login',
          icon: Icons.lock,
        ),
        Expanded(
          child: Form(
            key: formKey,
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                const SizedBox(height: 30),
                Text(
                  'Bentornato, ci sei mancato!',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 25),

                // Username text field.
                textField(
                  emailController,
                  'Email',
                  false,
                ),

                const SizedBox(height: 10),

                // Password text field.
                textField(
                  passwordController,
                  'Password',
                  true,
                ),

                const SizedBox(height: 10),

                // Forgot password link.
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
                          // Show reset password dialog.
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Form(
                                  key: resetKey,
                                  child: SimpleDialog(
                                    alignment: Alignment.center,
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Password dimenticata?',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.bold,
                                              ),
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
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25, right: 20, bottom: 20),
                                        child: Text(
                                          'Ricevi una mail per effettuare il reset della tua password',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
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
                                        height: 60,
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
                                            resetPassword();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: const Text('Password dimenticata?'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),
                // Sign in button.
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
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.grey[700]),
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

                // Google and Facebook sign in buttons.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google button.
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

                    // Facebook button.
                    IconButton(
                      onPressed: () {
                        final provider = Provider.of<FacebookSignInProvider>(
                            context,
                            listen: false);
                        provider.facebookLogin(context);
                      },
                      icon: Image.asset(
                        'assets/images/facebook.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Registration button.
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Non sei ancora registrato?',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.grey[700]),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RegistrationScreen()));
                    },
                    child: Text(
                      'Registrati ora',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.blue, fontWeight: FontWeight.bold),
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

  // Function to handle sign in process.
  Future signIn() async {
    if (!formKey.currentState!.validate()) {
      MySnackBar.showMySnackBar(context, "Credenziali in forma errata");
      return;
    }

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
        if (kDebugMode) {
          print(error);
        }
      }

      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      MySnackBar.showMySnackBar(context, error);

      return;
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  // Function to handle password reset process.
  Future resetPassword() async {
    if (!resetKey.currentState!.validate()) {
      MySnackBar.showMySnackBar(context, "Credenziali in forma errata");
      return;
    }

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
        MySnackBar.showMySnackBar(context, 'Email inviata');
      }
    } on FirebaseAuthException catch (e) {
      String error = e.code;

      if (e.code == 'user-not-found') {
        error = "Nessun utente registrato con questa mail";
      } else {
        if (kDebugMode) {
          print(e.code);
        }
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      MySnackBar.showMySnackBar(context, error);
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }
}

// Widget for square tiles used in the authentication screen.
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

// Widget for text fields used in the authentication screen.
Widget textField(controller, final String hintText, final bool obscureText) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: TextFormField(
      keyboardType:
          obscureText ? TextInputType.text : TextInputType.emailAddress,
      autocorrect: false,
      controller: controller,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => obscureText || EmailValidator.validate(value!)
          ? null
          : "Inserisci una mail valida",
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        fillColor: const Color.fromARGB(255, 231, 231, 231),
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
      ),
    ),
  );
}
